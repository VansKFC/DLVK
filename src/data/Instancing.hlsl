#if !defined(INSTANCING_INCLUDED)
	#include <commonVarsLayout.hlsl>
	
	float4 Position_WS( float4 v_pos_ms, float4 v_model_xform_row_0, float4 v_model_xform_row_1, float4 v_model_xform_row_2)
	{
		float4 v_pos_ws = float4(1.0, 1.0, 1.0, 1.0);
		v_pos_ws.x = dot(v_pos_ms, v_model_xform_row_0);
		v_pos_ws.y = dot(v_pos_ms, v_model_xform_row_1);
		v_pos_ws.z = dot(v_pos_ms, v_model_xform_row_2);
		return v_pos_ws;
	}
	#if defined(INSTANCING_DIP_ON)
		struct SInstanceData{
			float4 MODEL_XFORM[3];
			float4 COLOR0;
		};	
			
		#if defined(SHADER_PATH_OPENGL)
			$if defined(OPENGL_LAYOUT_BINDING)
				layout(std140, binding=INSTANCE_DATA_REGISTER) uniform InstancingData 
			$else
				layout(std140) uniform InstancingData 
			$endif
			{ 
				SInstanceData INSTANCE_DATA;
			};
		#else	
			CONST_DECL(SInstanceData INSTANCE_DATA, INSTANCE_DATA_REGISTER);
		#endif
	#endif

	//#if defined( INSTANCING_VS)
	#if defined(INSTANCING_VS_ON) || defined(INSTANCING_VSPLUS_ON)
		#if defined(INSTANCING_VS_ON)
			float4 CONST_PALETTE[XENON_INSTANCES_MAX * XENON_INSTANCES_CONSTS] : register(c0);
		#endif
		int VERTICES_PER_INSTANCE;
		int InstanceNumber(int i_vertex_index) { return (i_vertex_index + 0.5) / VERTICES_PER_INSTANCE; }
		int BaseVertexIndex(int i_vertex_index, int i_instance_index) { return i_vertex_index - i_instance_index * VERTICES_PER_INSTANCE; }

		float4 ModelXForm_Row0(int i_instance_index)
		{
			float4 v_model_xform_row_0;
			#if defined(INSTANCING_VS_ON)
				v_model_xform_row_0 = CONST_PALETTE[i_instance_index * XENON_INSTANCES_CONSTS + 0];
			#else
				asm
				{
					vfetch v_model_xform_row_0, i_instance_index, texcoord4;
				};
			#endif
			return v_model_xform_row_0;
		}
		float4 ModelXForm_Row1(int i_instance_index)
		{
			float4 v_model_xform_row_1;
			#if defined(INSTANCING_VS_ON)
				v_model_xform_row_1 = CONST_PALETTE[i_instance_index * XENON_INSTANCES_CONSTS + 1];
			#else
				asm
				{
					vfetch v_model_xform_row_1, i_instance_index, texcoord5;
				};
			#endif
			return v_model_xform_row_1;
		}
		float4 ModelXForm_Row2(int i_instance_index)
		{
			float4 v_model_xform_row_2;
			#if defined(INSTANCING_VS_ON)
				v_model_xform_row_2 = CONST_PALETTE[i_instance_index * XENON_INSTANCES_CONSTS + 2];
			#else
				asm
				{
					vfetch v_model_xform_row_2, i_instance_index, texcoord6;
				};
				#endif
			return v_model_xform_row_2;
		}
		float4 ColorUser_0(int i_instance_index)
		{
			float4 v_clr_usr_0;
			#if defined(INSTANCING_VS_ON)
				v_clr_usr_0 = CONST_PALETTE[i_instance_index * XENON_INSTANCES_CONSTS + 3];
			#else
				asm
				{
					vfetch v_clr_usr_0, i_instance_index, texcoord7;
				};
				#endif
			return v_clr_usr_0;
		}
		float4 Position_MS(int i_vertex_index_base)
		{
			float4 v_pos_ms;
			asm
			{
				vfetch v_pos_ms, i_vertex_index_base, position0;
			};
			return v_pos_ms;
		}
		float4 Position_WS(float4 v_pos_ms, int i_instance_index)
		{
			float4 v_model_xform_row_0 = ModelXForm_Row0(i_instance_index);
			float4 v_model_xform_row_1 = ModelXForm_Row1(i_instance_index);
			float4 v_model_xform_row_2 = ModelXForm_Row2(i_instance_index);
			return Position_WS(v_pos_ms, v_model_xform_row_0, v_model_xform_row_1, v_model_xform_row_2);
		}
		float4 Texcoord_0(int i_vertex_index_base)
		{
			float4 v_texcoord_0;
			asm
			{
				vfetch v_texcoord_0, i_vertex_index_base, texcoord0;
			};
			return v_texcoord_0;
		}
		float4 Texcoord_1(int i_vertex_index_base)
		{
			float4 v_texcoord_1;
			asm
			{
				vfetch v_texcoord_1, i_vertex_index_base, texcoord1;
			};
			return v_texcoord_1;
		}
		float4 Color_0(int i_vertex_index_base)
		{
			float4 v_color_0;
			asm
			{
				vfetch v_color_0, i_vertex_index_base, color0;
			};
			return v_color_0;
		}
		float4 Normal_MS(int i_vertex_index_base)
		{
			float4 v_normal_ms;
			asm
			{
				vfetch v_normal_ms, i_vertex_index_base, normal;
			};
			return v_normal_ms;
		}
		float4 Tangent_MS(int i_vertex_index_base)
		{
			float4 v_tangent_ms;
			asm
			{
				vfetch v_tangent_ms, i_vertex_index_base, tangent;
			};
			return v_tangent_ms;
		}
	#endif

	#define INSTANCING_INCLUDED 1     
#endif
