#define PI 3.1415926536

struct Box {
    vec3 position;  // minBound
    vec3 size;      // maxBound
};

bool isInsideBox(vec3 particlePosition, Box box) {
    vec3 boxMin = box.position;
    vec3 boxMax = box.position + box.size;

    return all(greaterThanEqual(particlePosition, boxMin)) &&
           all(lessThanEqual(particlePosition, boxMax));
}


vec3 snoiseVec3( vec3 x ){

	float s = TDSimplexNoise(vec3( x ));
	float s1 = TDSimplexNoise(vec3( x.y - 19.1 , x.z + 33.4 , x.x + 47.2 ));
	float s2 = TDSimplexNoise(vec3( x.z + 74.2 , x.x - 124.5 , x.y + 99.4 ));
	vec3 c = vec3( s , s1 , s2 );
	return c;

}

vec3 curlNoise(vec3 p) {

	const float e = .1;
	vec3 dx = vec3( e , 0.0 , 0.0 );
	vec3 dy = vec3( 0.0 , e , 0.0 );
	vec3 dz = vec3( 0.0 , 0.0 , e );

	vec3 p_x0 = snoiseVec3( p - dx );
	vec3 p_x1 = snoiseVec3( p + dx );
	vec3 p_y0 = snoiseVec3( p - dy );
	vec3 p_y1 = snoiseVec3( p + dy );
	vec3 p_z0 = snoiseVec3( p - dz );
	vec3 p_z1 = snoiseVec3( p + dz );

	float x = p_y1.z - p_y0.z - p_z1.y + p_z0.y;
	float y = p_z1.x - p_z0.x - p_x1.z + p_x0.z;
	float z = p_x1.y - p_x0.y - p_y1.x + p_y0.x;

	const float divisor = 1.0 / ( 2.0 * e );
	return normalize( vec3( x , y , z ) * divisor );
}

vec3 curlNoise2(vec3 p) {
	const float e = 0.1;
    vec3 dx = vec3(e, 0.0, 0.0);
    vec3 dy = vec3(0.0, e, 0.0);
    vec3 dz = vec3(0.0, 0.0, e);

    vec3 p_x0 = snoiseVec3(p - dx);
    vec3 p_x1 = snoiseVec3(p + dx);
    vec3 p_y0 = snoiseVec3(p - dy);
    vec3 p_y1 = snoiseVec3(p + dy);
    vec3 p_z0 = snoiseVec3(p - dz);
    vec3 p_z1 = snoiseVec3(p + dz);

    // Apply constraint to multiples of 45 degrees
    float angle = 90 * radians(1.0);  // Adjust the angle constraint as desired
    vec3 constrainedVec = vec3(
        cos(angle) * (p_x1.x - p_x0.x) - sin(angle) * (p_y1.x - p_y0.x),
        cos(angle) * (p_x1.y - p_x0.y) - sin(angle) * (p_y1.y - p_y0.y),
        cos(angle) * (p_x1.z - p_x0.z) - sin(angle) * (p_y1.z - p_y0.z)
    );

    float x = constrainedVec.y - p_z0.y + p_z1.y;
    float y = constrainedVec.z - p_z0.z + p_z1.z;
    float z = constrainedVec.x - p_x0.x + p_x1.x;

    const float divisor = 1.0 / (2.0 * e);
    return normalize(vec3(x, y, z)) * divisor;
}

vec3 conformToSphere(vec3 position, vec3 center, float radius) {
  vec3 direction = position - center;
  float distance2 = length(direction);
  vec3 normalizedDirection = direction / distance2;

  // Conform to sphere if outside the radius
  if(conformSwitchInOut == 0){
  if (distance2 > radius) {
    position = center + normalizedDirection * radius;
  }
  } else {
      // Check if the particle is inside the sphere
  if (distance2 < radius) {
        // Reflect the position to the closest point on the sphere's surface
       position = center + normalizedDirection * radius;
    }
	}
  return position;
}

vec3 attract(vec3 position, vec3 attractorpos, float attractorstrength, float distancethreshold){
	float distanceToAttractor = distance(position, attractorpos);
	vec3 attractionForce = vec3(0.0);
	if (distanceToAttractor < distancethreshold) {
	  	attractionForce = (attractorstrength/10) * normalize(attractorpos - position) / map(distanceToAttractor,0.01,distancethreshold,2,distancethreshold);
	}
	return attractionForce;
}

vec3 angleToDir(vec2 angle){
	return vec3(cos(angle.y)*cos(angle.x),cos(angle.y)*sin(angle.x),sin(angle.y));
}

ivec2 Index2XY(int index){
	return ivec2(index % int(uTDOutputInfo.res.z), floor(index / uTDOutputInfo.res.z));
}

float Hash(vec2 p) { return fract(mod(sin(dot(p,vec2(12.9898,78.233))) * 43758.5453, PI)); }

struct Grid {
    ivec3 cellCount;  // Number of cells along each axis
    vec3 pos;         // Position of the entire grid (minimum coordinates)
    vec3 size;        // Size of the entire grid
};

// Given a cell index, calculate the position of the cell in the grid
vec3 calculateCellPosition(Grid grid, ivec3 cellIndex) {
    return grid.pos + (grid.size / vec3(grid.cellCount)) * vec3(cellIndex);
}

// Check if a particle is inside a specific cell
bool isInsideCell(vec3 particlePosition, Grid grid, ivec3 cellIndex) {
    vec3 cellPosition = calculateCellPosition(grid, cellIndex);
    vec3 cellMin = cellPosition;
    vec3 cellMax = cellPosition + (grid.size / vec3(grid.cellCount));

    return all(greaterThanEqual(particlePosition, cellMin)) &&
           all(lessThanEqual(particlePosition, cellMax));
}

int numOfCells(Grid grid){
	return grid.cellCount.x * grid.cellCount.y * grid.cellCount.z;
}


vec3 calculateCircularForce(vec3 particlePosition, vec3 circleCenter, float radius, float strength) {
    // Calculate the vector from the particle to the center of the circle
    vec3 toCenter = circleCenter - particlePosition;
    
    // Calculate the angle between the particle and the x-axis
    float angle = atan(toCenter.y, toCenter.x);
    
    // Calculate the force direction using the angle
    vec3 forceDirection = vec3(cos(angle), sin(angle), 0.0);
    
    // Calculate the force magnitude using distance from the particle to the circle
    float distanceToCircle = length(toCenter) - radius;
    float forceMagnitude = distanceToCircle * strength;
    
    // Scale the force direction by the force magnitude
    vec3 radialForce = forceDirection * forceMagnitude;
    
    // Calculate the tangential force by rotating the force direction by 90 degrees
    vec3 tangentForce = vec3(-forceDirection.y, forceDirection.x, 0.0) * strength;
    
    // Combine radial and tangential forces
    vec3 totalForce = (radialForce + tangentForce);
    
    return totalForce;
}

vec3 calculateCircularForce2(vec3 particlePosition, vec3 circleCenter, float radius, float strength, vec3 rotationDegrees) {
    // Convert rotation angles from degrees to radians
    vec3 rotation = radians(rotationDegrees);

    // Calculate the vector from the particle to the center of the circle
    vec3 toCenter = circleCenter - particlePosition;

    // Rotate the toCenter vector according to the rotation vector
    float cosTheta = cos(rotation.z);
    float sinTheta = sin(rotation.z);
    mat3 rotationMatrix = mat3(
        cosTheta, -sinTheta, 0.0,
        sinTheta, cosTheta, 0.0,
        0.0, 0.0, 1.0
    );
    toCenter = rotationMatrix * toCenter;

    // Ensure the circle always faces upward
    toCenter.y = 0.0;

    // Calculate the angle between the particle and the x-axis
    float angle = atan(toCenter.z, toCenter.x);

    // Calculate the force direction using the angle
    vec3 forceDirection = vec3(cos(angle), 0.0, sin(angle));

    // Calculate the force magnitude using distance from the particle to the circle
    float distanceToCircle = length(toCenter) - radius;
    float forceMagnitude = distanceToCircle * strength;

    // Scale the force direction by the force magnitude
    vec3 radialForce = forceDirection * forceMagnitude;

    // Calculate the tangential force by rotating the force direction by 90 degrees
    vec3 tangentForce = vec3(-forceDirection.z, 0.0, forceDirection.x) * strength;

    // Combine radial and tangential forces
    vec3 totalForce = (radialForce + tangentForce);

    return totalForce;
}
