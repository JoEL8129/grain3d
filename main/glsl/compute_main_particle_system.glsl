uniform float uTime; 
uniform float uDelta;
uniform float uVelDamping;
uniform vec4 uNoiseFactor;
uniform float uNoiseStrength;
uniform float uRampRes_col;
uniform float uRampRes_size;
uniform float uLifeMult;
uniform float uNoiseAnimSpeed;
uniform float conformSwitchInOut;
uniform float uKillY;
uniform float uTowardsInit;
uniform vec2 uSopPointsRes;
uniform float uCurveThreshold,uCurveFalloff,uCurveStrength;
uniform float uCircularRadius,uCircularStrength;
uniform vec3 uCircularCenter, uCircularRotation;
#include <glsl_helper_basic>
//uniform vec3 uCameraPosition;
#define PI 3.1415926536
#define MAX_PARTICLES 1024

float size;
float alpha;
float age;
uniform int uMaxParticles;
int allParticles [MAX_PARTICLES];

uniform float minAge; 
uniform float maxAge;
uniform float uMaxSpeed;

uniform bool conformMode;

uniform float radiuscontrol;
uniform vec3 spherePos;


uniform vec3 attractorPoint1; //= vec3(1.0, 0.0, 0.0);  // Example attractor point
uniform vec3 attractorPoint2; //= vec3(0.0, 1.0, 0.0);  // Example second attractor point
uniform vec3 attractorPoint3;
uniform vec3 attractorPoint4;

uniform float attractorStrength1;// = 0.001;  // Adjust the strength of attractor 1
uniform float attractorStrength2;// = 0.0005;  // Adjust the strength of attractor 2
uniform float attractorStrength3;
uniform float attractorStrength4;

uniform float attractorThreshold1;// = 5.25;  // Adjust the threshold distance
uniform float attractorThreshold2;// = 2.5;
uniform float attractorThreshold3;
uniform float attractorThreshold4;

struct Particle {
	vec3 position;
	vec3 velocity;
	int index; 
	int cellKey;
};

layout (local_size_x = 8, local_size_y = 8) in;

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




//uSopPointsRes


// Function to calculate force along curve/normal tangents
/* vec3 calculateCurveForce(vec3 particlePosition, float threshold, float falloff,float strength) {
    vec3 totalForce = vec3(0.0);
	float totalWeight = 0.0;

    // Iterate through all surface points
    for (int i = 0; i < uSopPointsRes.x; ++i) {
    	for (int j = 0; j < uSopPointsRes.y; ++j) {
			vec3 surfacePointPositions = texelFetch(sTD2DInputs[6], ivec2(i, j), 0).xyz;
			vec3 surfacePointNormals = texelFetch(sTD2DInputs[7], ivec2(i, j), 0).xyz;
        // Calculate distance between particle and surface point
        float distanceP = distance(surfacePointPositions,particlePosition);

        // Check if the surface point is within the threshold
        if (distanceP < threshold) {
            // Calculate force direction along the normal tangent
			float weight = max(0.0, 1.0 - distanceP / threshold);
            vec3 forceDirection = (surfacePointNormals);

            // Calculate linear falloff factor based on distance
            float falloffFactor = 1.0 - distanceP / threshold;
            falloffFactor = max(0.0, falloffFactor);
			totalForce += weight * forceDirection;
            totalWeight += weight;

            // Calculate force magnitude based on falloff
            //float forceMagnitude = falloffFactor * falloff * strength;

            // Add force contribution from this surface point to total force
            //totalForce += forceMagnitude * forceDirection;
        }

		

    }
	}

	

    totalForce *= falloff * strength;

    return totalForce;
} */










void main(){

	Grid grid;
	grid.cellCount= ivec3(4,4,4);
	grid.pos = vec3(-5.0,-5.0,-5.0);
	grid.size = vec3(10.0,10.0,10.0);



	vec4 p = texelFetch(sTD2DInputs[0], ivec2(gl_GlobalInvocationID.xy), 0);
	vec4 v = texelFetch(sTD2DInputs[1], ivec2(gl_GlobalInvocationID.xy), 0);
	vec4 i = texelFetch(sTD2DInputs[2], ivec2(gl_GlobalInvocationID.xy), 0);
	vec4 iv = texelFetch(sTD2DInputs[5], ivec2(gl_GlobalInvocationID.xy), 0);
	//vec4 density = texelFetch(sTD3DInputs[0], ivec3(gl_GlobalInvocationID.xyz), 0);

	



	Particle particle; 

	particle.position = p.rgb;
	//particle.index = int(gl_GlobalInvocationID.x + gl_GlobalInvocationID.y * gl_NumWorkGroups.x * gl_WorkGroupSize.x);
	particle.index = int(gl_GlobalInvocationID.x+gl_GlobalInvocationID.y*3);

	vec3 pos = p.rgb;
	vec3 vel = v.rgb;
	vec3 ini = i.rgb;	
	float life = p.a;
	
/* 	for(int i =0;i<grid.cellCount.x;i++){
		for(int j =0;j<grid.cellCount.y;j++){
			for(int k =0;k<grid.cellCount.z;k++){
				if(isInsideCell(particle.position,grid,ivec3(i,j,k))) particle.cellKey = (709*i+859*j+331*k)%numOfCells(grid);
			}
		}
	} */
	
	float age = map(i.a,0,1,minAge,maxAge);

	
	vec3 attractionForce1 = attract(particle.position,attractorPoint1,attractorStrength1,attractorThreshold1);
	vec3 attractionForce2 = attract(particle.position,attractorPoint2,attractorStrength2,attractorThreshold2);
	
	//

	// Sample Color & Size Over Life Ramps 
	float normLife = map(life,0.0,age,0.0,1.0); //normalize age (0-maxAge) in Range 0-1 
	float realnormLife = normalize(life);
	vec4 ramp = texelFetch(sTD2DInputs[3], ivec2(normLife*uRampRes_col,0),0);
	vec4 ramp2 = texelFetch(sTD2DInputs[4], ivec2(normLife*uRampRes_size,0),0);

	if(life>=age){
		life = 0.; 
		particle.position = ini;
	}

	life+=0.01*uLifeMult;





	//vec3 circleForce = calculateCircularForce(vec3(particle.position.x,particle.position.y,particle.position.z),uCircularCenter,uCircularRadius,uCircularStrength);
	vec3 circleForce = calculateCircularForce2(vec3(particle.position.x,particle.position.y,particle.position.z),uCircularCenter,uCircularRadius,uCircularStrength,uCircularRotation);
	
	//vec3 curveForce = calculateCurveForce(particle.position,uCurveThreshold,uCurveFalloff,uCurveStrength);
//VELOCITY

	vec3 noise = uDelta * uNoiseFactor.x * curlNoise(pos * uNoiseFactor.y + (uTime*uNoiseAnimSpeed) * uNoiseFactor.z);
	vel+= noise * uNoiseStrength;
	//vel+= vortexForce1 * vortexStrength;
	vel += attractionForce1 + attractionForce2;
	vel += circleForce;
	//vel += curveForce;


	//vel += iv.xyz;
	vel *= uVelDamping;
	
	if(conformMode == true){
	particle.position = conformToSphere(particle.position, spherePos, radiuscontrol);
	}
	
	//vel = normalize(vel) * clamp(speed, 0.0, uMaxSpeed);
	//vel = normalize(vel)*uMaxSpeed*0.01; 
	
	vel += 0.000075*(ini-particle.position)*uTowardsInit;
	vel *= uMaxSpeed;
    particle.position+=vel;
	float speed = length(vel);
	//particle.position = fract(particle.position);

imageStore(mTDComputeOutputs[0], ivec2(gl_GlobalInvocationID.xy), TDOutputSwizzle(vec4(particle.position.x,particle.position.y*uKillY,particle.position.z,life)));
imageStore(mTDComputeOutputs[1], ivec2(gl_GlobalInvocationID.xy), TDOutputSwizzle(vec4(vel,ramp2.x)));
imageStore(mTDComputeOutputs[2], ivec2(gl_GlobalInvocationID.xy), TDOutputSwizzle(vec4(ramp)));
//imageStore(mTDComputeOutputs[2], ivec2(gl_GlobalInvocationID.xy), TDOutputSwizzle(vec4(map(particle.cellKey,0,numOfCells(grid),0.0,1.0),0,0,1.0)));

imageStore(mTDComputeOutputs[3], ivec2(gl_GlobalInvocationID.xy), TDOutputSwizzle(vec4(normLife,speed,ramp2.x,particle.index)));

}

