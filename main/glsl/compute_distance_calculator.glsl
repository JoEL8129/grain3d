// Example Compute Shader

// uniform float exampleUniform;

//layout (local_size_x = 1, local_size_y = 1) in;

uniform int numSpeakers;


void main()
{
	vec4 color;

	ivec2 gid = ivec2(gl_GlobalInvocationID.xy);
	
	vec4 posParticles = texelFetch(sTD2DInputs[0], gid, 0);
	vec3 particlePos = posParticles.xyz;
	
    // Iterate over each speaker position
    for (int i = 0; i < numSpeakers; ++i) {
		
		vec4 posSpeakers = texelFetch(sTD2DInputs[1], ivec2(i, 0), 0);
        vec3 speakerPos = posSpeakers.xyz;

        float distance2 = distance(particlePos, speakerPos);


        ivec2 outputCoord = ivec2(gid.x * numSpeakers + i, gid.y);
		        //ivec2 outputCoord = ivec2(gid.x, i);
		 imageStore(mTDComputeOutputs[0], outputCoord, TDOutputSwizzle(vec4(distance2,0.0,posParticles.a,0.0)));

    }
    
	
}
