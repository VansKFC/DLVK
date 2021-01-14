#if defined(MORPH_TARGETS)

#define MAX_MORPHTARGETS_COUNT 64 // keep in sync with MESH_NUM_MORPHS_TARGETS engine const

#if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11)

    #define NumMorphTargetPairs         INT_CONST_0
    #define MorphTargetsWeightOffset    CONST_15

	int4 NumMorphTargetPairs;
	float4 MorphTargetsWeightOffset[MAX_MORPHTARGETS_COUNT/2];

	#if defined(SHADER_PATH_ORBIS)
		DataBuffer<float4> t_MorphTargets;
	#else
		Buffer<float4> t_MorphTargets;
	#endif

    void GetMorphedVertexDelta(inout float3 p, int vertexIndex)
    {
    	for (int i = 0; i < NumMorphTargetPairs.x; i++)
    	{
    		uint idx0 = vertexIndex + (int)MorphTargetsWeightOffset[i].x;
    		uint idx1 = vertexIndex + (int)MorphTargetsWeightOffset[i].z;

            float3 vMorphDelta0 = t_MorphTargets[idx0].xyz;
            float3 vMorphDelta1 = t_MorphTargets[idx1].xyz;

            p += vMorphDelta0 * MorphTargetsWeightOffset[i].y;
            p += vMorphDelta1 * MorphTargetsWeightOffset[i].w;
    	}
    }
#endif

#if defined(SHADER_PATH_OPENGL)
	#define NumMorphTargetPairs         INT_CONST_0
	#define MorphTargetsWeightOffset    CONST_15
	
	uniform int4 NumMorphTargetPairs;
	uniform float4 MorphTargetsWeightOffset[MAX_MORPHTARGETS_COUNT/2];
		
	$if !defined(OPENGL_NO_SSBO)
		layout(std430, binding = 0) buffer MorphTargets
		{  
			float4 t_MorphTargets[]; 
		}; 

		void GetMorphedVertexDelta(inout float3 p, int vertexIndex)
		{
			for (int i = 0; i < NumMorphTargetPairs.x; i++)
			{
				int idx0 = vertexIndex + int(MorphTargetsWeightOffset[i].x);
				int idx1 = vertexIndex + int(MorphTargetsWeightOffset[i].z);

				float3 vMorphDelta0 = t_MorphTargets[idx0].xyz;
				float3 vMorphDelta1 = t_MorphTargets[idx1].xyz;

				p += vMorphDelta0 * MorphTargetsWeightOffset[i].y;
				p += vMorphDelta1 * MorphTargetsWeightOffset[i].w;
			}
		}
	$else
		uniform sampler2D MorphTargets;
		
		float CalcX(int id)
		{
			return (float(mod(id, MorphTargetsSize)) + 0.5) / float(MorphTargetsSize);
		}
		
		float CalcY(int id)
		{
			return (float(id - mod(id, MorphTargetsSize)) + 0.5) / float(MorphTargetsSize * MorphTargetsSize);
		}
		
		void GetMorphedVertexDelta(inout float3 p, int vertexIndex)
		{
			for (int i = 0; i < NumMorphTargetPairs.x; i++)
			{
				int idx0 = vertexIndex + int(MorphTargetsWeightOffset[i].x);
				int idx1 = vertexIndex + int(MorphTargetsWeightOffset[i].z);

				float3 vMorphDelta0 = texture(MorphTargets, vec2( CalcX(idx0), CalcY(idx0) ) ).xyz;
				float3 vMorphDelta1 = texture(MorphTargets, vec2( CalcX(idx1), CalcY(idx1) ) ).xyz;

				p += vMorphDelta0 * MorphTargetsWeightOffset[i].y;
				p += vMorphDelta1 * MorphTargetsWeightOffset[i].w;
			}
		}
	$endif
#endif

#if defined(SHADER_PATH_X360)
    #define NumMorphTargetPairs         INT_CONST_0
    #define MorphTargetsWeightOffset    CONST_15

    int NumMorphTargetPairs;
    float4 MorphTargetsWeightOffset[MAX_MORPHTARGETS_COUNT/2];

    void GetMorphedVertexDelta(inout float3 p, int vertexIndex : index)
    {
    	for (int i = 0; i < NumMorphTargetPairs; i++)
    	{
    		uint idx0 = vertexIndex + (int)MorphTargetsWeightOffset[i].x;
    		uint idx1 = vertexIndex + (int)MorphTargetsWeightOffset[i].z;

            float4 vMorphDelta0, vMorphDelta1;
        	asm
            {
        	    vfetch vMorphDelta0, idx0, position3;
        	    vfetch vMorphDelta1, idx1, position3;
            };

            vMorphDelta0 /= X360_MORPH_TARGET_SCALE;
            vMorphDelta1 /= X360_MORPH_TARGET_SCALE;

            p.xyz += vMorphDelta0.xyz * MorphTargetsWeightOffset[i].y;
            p.xyz += vMorphDelta1.xyz * MorphTargetsWeightOffset[i].w;
    	}
    }
#endif

#endif
