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
#include <glsl_helper_particle_functions>

//uniform vec3 uCameraPosition;

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
    float maxSpeed;
    float age;

	int index; 
	int cellKey;
};

layout (local_size_x = 8, local_size_y = 8) in;




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

