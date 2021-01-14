#if !defined(SKINNING_INCLUDED)
	
	#if defined(SKINNING) || defined(SKINNING_ONE_BONE)                     

		// sync with commonVarsLayout.hlsl
        #if defined(SHADER_PATH_DX10) || defined(SHADER_PATH_DX11) || defined(SHADER_PATH_OPENGL)
            #define MTX_PER_BONE 2  // world, prev_world
        #else
            #define MTX_PER_BONE 1  // world
        #endif
         
		
		#include <commonVarsLayout.hlsl>            

		#if defined(SKINNING_ONE_BONE)
			void VertexBlend_XFORM(in float v_indices_in, 
									out float4 MODEL_XFORM_VB_R0, out float4 MODEL_XFORM_VB_R1, out float4 MODEL_XFORM_VB_R2)
			{
				float v_indices = v_indices_in * ENGINE__SKINNING_BONES_UNPACK;

				MODEL_XFORM_VB_R0 =  CONST_PALETTE[int(v_indices)*MTX_PER_BONE];
				MODEL_XFORM_VB_R1 =  CONST_PALETTE[int(v_indices)*MTX_PER_BONE + 1];
				MODEL_XFORM_VB_R2 =  CONST_PALETTE[int(v_indices)*MTX_PER_BONE + 2];
			}
			
			void VertexBlend_XFORM_prev(in float v_indices_in, 
									out float4 MODEL_XFORM_VB_R0, out float4 MODEL_XFORM_VB_R1, out float4 MODEL_XFORM_VB_R2)
			{
				float v_indices = v_indices_in * ENGINE__SKINNING_BONES_UNPACK;

				MODEL_XFORM_VB_R0 =  CONST_PALETTE[int(v_indices)*MTX_PER_BONE + 3];
				MODEL_XFORM_VB_R1 =  CONST_PALETTE[int(v_indices)*MTX_PER_BONE + 4];
				MODEL_XFORM_VB_R2 =  CONST_PALETTE[int(v_indices)*MTX_PER_BONE + 5];
			}
		#else
			void VertexBlend_XFORM(in float4 v_weights_in, in float4 v_indices_in, 
									out float4 MODEL_XFORM_VB_R0, out float4 MODEL_XFORM_VB_R1, out float4 MODEL_XFORM_VB_R2)
			{
				float4 v_weights = v_weights_in;
				float4 v_indices = v_indices_in * ENGINE__SKINNING_BONES_UNPACK;

				MODEL_XFORM_VB_R0 =  CONST_PALETTE[int(v_indices.x)*MTX_PER_BONE] * v_weights.x +
									 CONST_PALETTE[int(v_indices.y)*MTX_PER_BONE] * v_weights.y +
									 CONST_PALETTE[int(v_indices.z)*MTX_PER_BONE] * v_weights.z +
									 CONST_PALETTE[int(v_indices.w)*MTX_PER_BONE] * v_weights.w;

				MODEL_XFORM_VB_R1 =  CONST_PALETTE[int(v_indices.x)*MTX_PER_BONE + 1] * v_weights.x +
									 CONST_PALETTE[int(v_indices.y)*MTX_PER_BONE + 1] * v_weights.y +
									 CONST_PALETTE[int(v_indices.z)*MTX_PER_BONE + 1] * v_weights.z +
									 CONST_PALETTE[int(v_indices.w)*MTX_PER_BONE + 1] * v_weights.w;

				MODEL_XFORM_VB_R2 =  CONST_PALETTE[int(v_indices.x)*MTX_PER_BONE + 2] * v_weights.x +
									 CONST_PALETTE[int(v_indices.y)*MTX_PER_BONE + 2] * v_weights.y +
									 CONST_PALETTE[int(v_indices.z)*MTX_PER_BONE + 2] * v_weights.z +
									 CONST_PALETTE[int(v_indices.w)*MTX_PER_BONE + 2] * v_weights.w;
			}
			
			void VertexBlend_XFORM_prev(in float4 v_weights_in, in float4 v_indices_in, 
						out float4 MODEL_XFORM_VB_R0, out float4 MODEL_XFORM_VB_R1, out float4 MODEL_XFORM_VB_R2)
			{
				float4 v_weights = v_weights_in;
				float4 v_indices = v_indices_in * ENGINE__SKINNING_BONES_UNPACK;

				MODEL_XFORM_VB_R0 =  CONST_PALETTE[int(v_indices.x)*MTX_PER_BONE + 3] * v_weights.x +
										CONST_PALETTE[int(v_indices.y)*MTX_PER_BONE + 3] * v_weights.y +
										CONST_PALETTE[int(v_indices.z)*MTX_PER_BONE + 3] * v_weights.z +
										CONST_PALETTE[int(v_indices.w)*MTX_PER_BONE + 3] * v_weights.w;

				MODEL_XFORM_VB_R1 =  CONST_PALETTE[int(v_indices.x)*MTX_PER_BONE + 4] * v_weights.x +
										CONST_PALETTE[int(v_indices.y)*MTX_PER_BONE + 4] * v_weights.y +
										CONST_PALETTE[int(v_indices.z)*MTX_PER_BONE + 4] * v_weights.z +
										CONST_PALETTE[int(v_indices.w)*MTX_PER_BONE + 4] * v_weights.w;

				MODEL_XFORM_VB_R2 =  CONST_PALETTE[int(v_indices.x)*MTX_PER_BONE + 5] * v_weights.x +
										CONST_PALETTE[int(v_indices.y)*MTX_PER_BONE + 5] * v_weights.y +
										CONST_PALETTE[int(v_indices.z)*MTX_PER_BONE + 5] * v_weights.z +
										CONST_PALETTE[int(v_indices.w)*MTX_PER_BONE + 5] * v_weights.w;
			}
			
		#endif           
	#endif

	#define SKINNING_INCLUDED 1     
#endif
