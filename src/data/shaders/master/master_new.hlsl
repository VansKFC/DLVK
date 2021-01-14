#include <common.hlsl>

#define SWIZZLE1_0 .x
#define SWIZZLE1_1 .y
#define SWIZZLE1_2 .z
#define SWIZZLE1_3 .w
#define SWIZZLE2_0 .xy
#define SWIZZLE2_2 .zw

#define TEX_INV_SIZE(a) TEX_INV_SIZE_##a

#if !defined(VS_PRECISE)
	#define VS_PRECISE_DEF
#else
	#define VS_PRECISE_DEF precise
#endif

#if !defined(PS_PRECISE)
	#define PS_PRECISE_DEF
#else
	#define PS_PRECISE_DEF precise
#endif

#if !defined(HS_PRECISE)
	#define HS_PRECISE_DEF
#else
	#define HS_PRECISE_DEF precise
#endif

#if !defined(DS_PRECISE)
	#define DS_PRECISE_DEF
#else
	#define DS_PRECISE_DEF precise
#endif


#if defined (VERTEXSHADER)

	#if defined(INSTANCING_VS_ON) || defined(INSTANCING_VSPLUS_ON) || defined(INSTANCING_DIP_ON)
		#include <Instancing.hlsl>
	#endif

	#if defined(REQ_SKINNING_ONE_BONE) || defined(REQ_SKINNING)
		#include <skinning.hlsl>
	#endif

	#if defined(REQ_MORPH_TARGETS)
		#include <VertexMorphing.hlsl>
	#endif

	#if defined(SHADER_PATH_OPENGL)

		#define V2P_REQUIRED_FIELD
		#define V_POS_OUT_TC gl_Position
		#define PS_VFACE_FIELD

		#define VRT_PARAMS void

		#define INPUT_STRUCT_NAME_DOT
		#define V2P_STRUCT_NAME_DOT

	#else

		#define VRT_PARAMS VS_PRECISE_DEF INPUT_STRUCT INPUT_STRUCT_NAME, out VS_PRECISE_DEF V2P_STRUCT V2P_STRUCT_NAME


		#define V2P_STRUCT_NAME outTC

		#define V2P_STRUCT_NAME_DOT V2P_STRUCT_NAME.

		#define INPUT_STRUCT_NAME_DOT INPUT_STRUCT_NAME.


        #if defined(D_TESSELLATION_ON)
            #define V2P_REQUIRED_FIELD float4 v_pos_out : WORLDPOS;
		    #define V_POS_OUT_WS V2P_STRUCT_NAME.v_pos_out
        #else
			#if defined(SHADER_PATH_ORBIS)
				#define V2P_REQUIRED_FIELD float4 v_pos_out : SV_POSITION;
			#else
				#define V2P_REQUIRED_FIELD float4 v_pos_out : POSITION;
			#endif
		    #define V_POS_OUT_TC V2P_STRUCT_NAME.v_pos_out
        #endif


		#define PS_VFACE_FIELD

		#define INPUT_STRUCT INs
		#define INPUT_STRUCT_NAME inputs

	#endif


	#if !defined(BLENDWEIGHT_TYPE) && defined(REQ_SKINNING) && !defined(REQ_SKINNING_ONE_BONE)
		#define BLENDWEIGHT_TYPE float4
		#define BLENDWEIGHT_NAME I_SKINNING_WEIGHTS
	#endif

	#if !defined(BLENDINDICES_TYPE) && (defined(REQ_SKINNING) || defined(REQ_SKINNING_ONE_BONE))
		#define BLENDINDICES_TYPE float4
		#define BLENDINDICES_NAME I_SKINNING_INDEX
	#endif

	#if defined(REQ_MORPH_TARGETS)

		#if defined(SHADER_PATH_OPENGL)
			//#define INDEX_TYPE
			//#define INDEX_SEMANTIC
			#define INDEX_NAME gl_VertexID

		#else
			#define INDEX_NAME I_MORPH_INDEX

			#if defined(SHADER_PATH_X360)
				#define INDEX_TYPE int
				#define INDEX_SEMANTIC INDEX
			#else
				#define INDEX_TYPE unsigned int
				#define INDEX_SEMANTIC SV_VERTEXID
			#endif
		#endif
	#endif


	    BEGIN_STRUCT(INPUT_STRUCT)

			#if !defined(INSTANCING_VS_ON) && !defined(INSTANCING_VSPLUS_ON)

				#if defined (POSITION_TYPE)
					#if defined(SHADER_PATH_ORBIS)
						INPUT_DECL(POSITION_TYPE POSITION_NAME, SV_POSITION);
					#else
						INPUT_DECL(POSITION_TYPE POSITION_NAME, POSITION);
					#endif
				#endif

				#if defined (POSITION0_TYPE)
					INPUT_DECL(POSITION0_TYPE POSITION0_NAME, POSITION0);
				#endif

				#if defined (POSITION1_TYPE)
					INPUT_DECL(POSITION1_TYPE POSITION1_NAME, POSITION1);
				#endif


				#if defined (BLENDWEIGHT_TYPE)
					INPUT_DECL(BLENDWEIGHT_TYPE BLENDWEIGHT_NAME, BLENDWEIGHT);
				#endif

				#if defined (BLENDWEIGHT1_TYPE)
					INPUT_DECL(BLENDWEIGHT1_TYPE BLENDWEIGHT1_NAME, BLENDWEIGHT1);
				#endif


				#if defined (COLOR_TYPE)
					INPUT_DECL(COLOR_TYPE COLOR_NAME, COLOR);
				#endif

				#if defined (COLOR0_TYPE)
					INPUT_DECL(COLOR0_TYPE COLOR0_NAME, COLOR0);
				#endif

				#if defined (COLOR1_TYPE)
					INPUT_DECL(COLOR1_TYPE COLOR1_NAME, COLOR1);
				#endif

				#if defined (COLOR2_TYPE)
					INPUT_DECL(COLOR2_TYPE COLOR2_NAME, COLOR2);
				#endif

				#if defined (COLOR3_TYPE)
					INPUT_DECL(COLOR3_TYPE COLOR3_NAME, COLOR3);
				#endif

				#if defined (BLENDINDICES_TYPE)
					INPUT_DECL(BLENDINDICES_TYPE BLENDINDICES_NAME, BLENDINDICES);
				#endif

				#if defined (INDEX_TYPE)
					INPUT_DECL(INDEX_TYPE INDEX_NAME, INDEX_SEMANTIC);
				#endif

				#if defined (NORMAL_TYPE)
					INPUT_DECL(NORMAL_TYPE NORMAL_NAME, NORMAL);
				#endif

				#if defined (NORMAL0_TYPE)
					INPUT_DECL(NORMAL0_TYPE NORMAL0_NAME, NORMAL0);
				#endif

				#if defined (NORMAL1_TYPE)
					INPUT_DECL(NORMAL1_TYPE NORMAL1_NAME, NORMAL1);
				#endif

				#if defined (TANGENT_TYPE)
					INPUT_DECL(TANGENT_TYPE TANGENT_NAME, TANGENT);
				#endif

				#if defined (TANGENT0_TYPE)
					INPUT_DECL(TANGENT0_TYPE TANGENT0_NAME, TANGENT0);
				#endif

				#if defined (TANGENT1_TYPE)
					INPUT_DECL(TANGENT1_TYPE TANGENT1_NAME, TANGENT1);
				#endif

				#if defined (BINORMAL_TYPE)
					INPUT_DECL(BINORMAL_TYPE BINORMAL_NAME, BINORMAL);
				#endif

				#if defined (BINORMAL0_TYPE)
					INPUT_DECL(BINORMAL0_TYPE BINORMAL0_NAME, BINORMAL0);
				#endif

				#if defined (BINORMAL1_TYPE)
					INPUT_DECL(BINORMAL1_TYPE BINORMAL0_NAME, BINORMAL1);
				#endif

				#if defined (TEXCOORD_TYPE)
					INPUT_DECL(TEXCOORD_TYPE TEXCOORD_NAME, TEXCOORD);
				#endif

				#if defined (TEXCOORD0_TYPE)
					INPUT_DECL(TEXCOORD0_TYPE TEXCOORD0_NAME, TEXCOORD0);
				#endif

				#if defined (TEXCOORD1_TYPE)
					INPUT_DECL(TEXCOORD1_TYPE TEXCOORD1_NAME, TEXCOORD1);
				#endif

				#if defined (TEXCOORD2_TYPE)
					INPUT_DECL(TEXCOORD2_TYPE TEXCOORD2_NAME, TEXCOORD2);
				#endif

				#if defined (TEXCOORD3_TYPE)
					INPUT_DECL(TEXCOORD3_TYPE TEXCOORD3_NAME, TEXCOORD3);
				#endif

				#if defined (TEXCOORD4_TYPE)
					INPUT_DECL(TEXCOORD4_TYPE TEXCOORD4_NAME, TEXCOORD4);
				#endif

				#if defined (TEXCOORD5_TYPE)
					INPUT_DECL(TEXCOORD5_TYPE TEXCOORD5_NAME, TEXCOORD5);
				#endif

				#if defined (TEXCOORD6_TYPE)
					INPUT_DECL(TEXCOORD6_TYPE TEXCOORD6_NAME, TEXCOORD6);
				#endif

				#if defined (TEXCOORD7_TYPE)
					INPUT_DECL(TEXCOORD7_TYPE TEXCOORD7_NAME, TEXCOORD7);
				#endif

			#endif

			#if defined(INSTANCING_ON)
				#if defined(INSTANCING_VS_ON) || defined(INSTANCING_VSPLUS_ON)
					INPUT_DECL(int VertexIndex, INDEX);
				#elif defined(INSTANCING_SM30_ON)
					INPUT_DECL(float4 MODEL_XFORM_I_R0, TEXCOORD4);
					INPUT_DECL(float4 MODEL_XFORM_I_R1, TEXCOORD5);
					INPUT_DECL(float4 MODEL_XFORM_I_R2, TEXCOORD6);

					#if defined(COLOR_USER_TYPE)
						INPUT_DECL(float4 v_const_0, TEXCOORD7);
					#endif
				#endif
			#endif

		END_STRUCT



		#if defined(TEXTURE_VS_NAME_0)
			uniform TEXTURE_VS_TYPE_0 TEXTURE_VS_NAME_0;
		#endif

		#if defined(SAMPLER_VS_NAME_0)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_0 PRAGMA_VS_0
			#endif

			#if defined(SAMPLER_VS_TYPE_0)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_0 SAMPLER_VS_NAME_0, 0);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_1)
			uniform TEXTURE_VS_TYPE_1 TEXTURE_VS_NAME_1;
		#endif

		#if defined(SAMPLER_VS_NAME_1)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_1 PRAGMA_VS_1
			#endif

			#if defined(SAMPLER_VS_TYPE_1)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_1 SAMPLER_VS_NAME_1, 1);
			#endif

		#endif

		#if defined(TEXTURE_VS_NAME_2)
			uniform TEXTURE_VS_TYPE_2 TEXTURE_VS_NAME_2;
		#endif

		#if defined(SAMPLER_VS_NAME_2)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_2 PRAGMA_VS_2
			#endif
			#if defined(SAMPLER_VS_TYPE_2)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_2 SAMPLER_VS_NAME_2, 2);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_3)
			uniform TEXTURE_VS_TYPE_3 TEXTURE_VS_NAME_3;
		#endif

		#if defined(SAMPLER_VS_NAME_3)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_3 PRAGMA_VS_3
			#endif
			#if defined(SAMPLER_VS_TYPE_3)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_3 SAMPLER_VS_NAME_3, 3);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_4)
			uniform TEXTURE_VS_TYPE_4 TEXTURE_VS_NAME_4;
		#endif

		#if defined(SAMPLER_VS_NAME_4)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_4 PRAGMA_VS_4
			#endif
			#if defined(SAMPLER_VS_TYPE_4)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_4 SAMPLER_VS_NAME_4, 4);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_5)
			uniform TEXTURE_VS_TYPE_5 TEXTURE_VS_NAME_5;
		#endif

		#if defined(SAMPLER_VS_NAME_5)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_5 PRAGMA_VS_5
			#endif
			#if defined(SAMPLER_VS_TYPE_5)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_5 SAMPLER_VS_NAME_5, 5);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_6)
			uniform TEXTURE_VS_TYPE_6 TEXTURE_VS_NAME_6;
		#endif

		#if defined(SAMPLER_VS_NAME_6)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_6 PRAGMA_VS_6
			#endif
			#if defined(SAMPLER_VS_TYPE_6)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_6 SAMPLER_VS_NAME_6, 6);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_7)
			uniform TEXTURE_VS_TYPE_7 TEXTURE_VS_NAME_7;
		#endif

		#if defined(SAMPLER_VS_NAME_7)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_7 PRAGMA_VS_7
			#endif
			#if defined(SAMPLER_VS_TYPE_7)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_7 SAMPLER_VS_NAME_7, 7);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_8)
			uniform TEXTURE_VS_TYPE_8 TEXTURE_VS_NAME_8;
		#endif

		#if defined(SAMPLER_VS_NAME_8)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_8 PRAGMA_VS_8
			#endif
			#if defined(SAMPLER_VS_TYPE_8)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_8 SAMPLER_VS_NAME_8, 8);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_9)
			uniform TEXTURE_VS_TYPE_9 TEXTURE_VS_NAME_9;
		#endif

		#if defined(SAMPLER_VS_NAME_9)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_9 PRAGMA_VS_9
			#endif
			#if defined(SAMPLER_VS_TYPE_9)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_9 SAMPLER_VS_NAME_9, 9);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_10)
			uniform TEXTURE_VS_TYPE_10 TEXTURE_VS_NAME_10;
		#endif

		#if defined(SAMPLER_VS_NAME_10)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_10 PRAGMA_VS_10
			#endif
			#if defined(SAMPLER_VS_TYPE_10)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_10 SAMPLER_VS_NAME_10, 10);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_11)
			uniform TEXTURE_VS_TYPE_11 TEXTURE_VS_NAME_11;
		#endif

		#if defined(SAMPLER_VS_NAME_11)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_11 PRAGMA_VS_11
			#endif
			#if defined(SAMPLER_VS_TYPE_11)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_11 SAMPLER_VS_NAME_11, 11);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_12)
			uniform TEXTURE_VS_TYPE_12 TEXTURE_VS_NAME_12;
		#endif

		#if defined(SAMPLER_VS_NAME_12)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_12 PRAGMA_VS_12
			#endif
			#if defined(SAMPLER_VS_TYPE_12)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_12 SAMPLER_VS_NAME_12, 12);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_13)
			uniform TEXTURE_VS_TYPE_13 TEXTURE_VS_NAME_13;
		#endif

		#if defined(SAMPLER_VS_NAME_13)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_13 PRAGMA_VS_13
			#endif
			#if defined(SAMPLER_VS_TYPE_13)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_13 SAMPLER_VS_NAME_13, 13);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_14)
			uniform TEXTURE_VS_TYPE_14 TEXTURE_VS_NAME_14;
		#endif

		#if defined(SAMPLER_VS_NAME_14)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_14 PRAGMA_VS_14
			#endif
			#if defined(SAMPLER_VS_TYPE_14)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_14 SAMPLER_VS_NAME_14, 14);
			#endif
		#endif

		#if defined(TEXTURE_VS_NAME_15)
			uniform TEXTURE_VS_TYPE_15 TEXTURE_VS_NAME_15;
		#endif

		#if defined(SAMPLER_VS_NAME_15)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat SAMPLER_VS_NAME_15 PRAGMA_VS_15
			#endif
			#if defined(SAMPLER_VS_TYPE_15)
				SAMPLER_VS_DECL(SAMPLER_VS_TYPE_15 SAMPLER_VS_NAME_15, 15);
			#endif
		#endif






#elif defined(PIXELSHADER) && !defined(HULLSHADER_PRESENT)

	#if defined(SHADER_PATH_OPENGL)
		#define PIX_PARAMS void

		#define OUTPUT_STRUCT_NAME_DOT
		#define V2P_STRUCT_NAME_DOT

		#define V_POS_SS_TC gl_FragCoord
		//layout(origin_upper_left) in vec4 gl_FragCoord;

		#define V2P_REQUIRED_FIELD
		#define PS_VFACE_FIELD

	#else

		#define OUTPUT_STRUCT_NAME_DOT OUTPUT_STRUCT_NAME.

		#define PIX_PARAMS PS_PRECISE_DEF V2P_STRUCT V2P_STRUCT_NAME, out PS_PRECISE_DEF OUTPUT_STRUCT OUTPUT_STRUCT_NAME

		#define V2P_STRUCT_NAME inTC

		#define V2P_STRUCT_NAME_DOT V2P_STRUCT_NAME.
		#define D2P_STRUCT_NAME_DOT D2P_STRUCT_NAME.

		#define V_POS_SS_TC V2P_STRUCT_NAME.v_pos_ss


		#if defined(SHADER_PATH_DX1x)
			#define V2P_REQUIRED_FIELD float4 v_pos_ss: SV_POSITION;
			#define PS_VFACE_FIELD bool f_side_internal: SV_ISFRONTFACE;
			#define gl_FrontFacing (V2P_STRUCT_NAME.f_side_internal)
		#else
			#define V2P_REQUIRED_FIELD float4 v_pos_ss: VPOS;
			#define PS_VFACE_FIELD FLOAT f_side_internal: VFACE;

			#if defined(SHADER_PATH_X360)
				#define gl_FrontFacing (V2P_STRUCT_NAME.f_side_internal > 0.0)
			#else
				#define gl_FrontFacing (V2P_STRUCT_NAME.f_side_internal < 0.0)
			#endif
		#endif


		#define OUTPUT_STRUCT OUTs
		#define OUTPUT_STRUCT_NAME outputs

	#endif

	#define SELECT_VD(idx) uv_coord_##idx

	BEGIN_STRUCT(OUTPUT_STRUCT)

		#if defined (COLOR_OUT_TYPE)
			OUTPUT_COL(COLOR_OUT_TYPE COLOR_OUT_NAME, OUT_COLOR_SEMANTIC(0));
		#endif

		#if defined (COLOR0_OUT_TYPE)
			OUTPUT_COL(COLOR0_OUT_TYPE COLOR0_OUT_NAME, OUT_COLOR_SEMANTIC(0));
		#endif

		#if defined (COLOR1_OUT_TYPE)
			OUTPUT_COL(COLOR1_OUT_TYPE COLOR1_OUT_NAME, OUT_COLOR_SEMANTIC(1));
		#endif

		#if defined (COLOR2_OUT_TYPE)
			OUTPUT_COL(COLOR2_OUT_TYPE COLOR2_OUT_NAME, OUT_COLOR_SEMANTIC(2));
		#endif

		#if defined (COLOR3_OUT_TYPE)
			OUTPUT_COL(COLOR3_OUT_TYPE COLOR3_OUT_NAME, OUT_COLOR_SEMANTIC(3));
		#endif

	END_STRUCT

#endif


// HULLSHADER and tesselleator fun

#if defined(HULLSHADER)

		#define V2P_STRUCT_NAME inTC
		#define H2D_STRUCT_NAME outHTC

		#define T2D_STRUCT_NAME outTC

        #define T2D_STRUCT_NAME_DOT T2D_STRUCT_NAME.

        #define INPUT_STRUCT_NAME V2P_STRUCT_NAME

		#define PS_VFACE_FIELD


		#define HULL_PARAMS HS_PRECISE_DEF InputPatch< V2P_STRUCT, HULLDOMAIN > V2P_STRUCT_NAME, uint CPID : SV_OUTPUTCONTROLPOINTID

		#define TESSELLATOR_PARAMS HS_PRECISE_DEF InputPatch< V2P_STRUCT, HULLDOMAIN > V2P_STRUCT_NAME, OutputPatch< H2D_STRUCT, HULLDOMAIN > H2D_STRUCT_NAME, out HS_PRECISE_DEF T2D_STRUCT T2D_STRUCT_NAME


		// input
        #define V2P_STRUCT_NAME_DOT

		// output
		#define H2D_STRUCT_NAME_DOT H2D_STRUCT_NAME.


        #define V2P_REQUIRED_FIELD float4 v_pos_ws : WORLDPOS;
		//#define V_POS_WS V2P_STRUCT_NAME.v_pos_ws
        #define V_POS_WS(a) V2P_STRUCT_NAME[a].v_pos_ws


        #define H2D_REQUIRED_FIELD float4 v_pos_out_ws : WORLDPOS;
		#define V_POS_OUT_WS H2D_STRUCT_NAME.v_pos_out_ws

        #if HULLDOMAIN == 3
            #define EDGES_COUNT 3
        #elif HULLDOMAIN == 4
            #define EDGES_COUNT 4
        #else
            #define EDGES_COUNT 2
        #endif

        #define T2D_REQUIRED_FIELD float o_edges[EDGES_COUNT] : SV_TESSFACTOR; float o_inside : SV_INSIDETESSFACTOR;
        #define O_EDGES T2D_STRUCT_NAME.o_edges
        #define O_INSIDE T2D_STRUCT_NAME.o_inside

        #define OUTPUT_SAME_AS_INPUT(a) Output_same_as_input(a, V2P_STRUCT_NAME, H2D_STRUCT_NAME)
		#define OUTPUT_SAME_AS_INPUT_PRECISE(a) Output_same_as_input_precise(a, V2P_STRUCT_NAME, H2D_STRUCT_NAME)


#endif


#if defined(SHADER_PATH_X360)
    #define ISOLATE [isolate]
#else
    #define ISOLATE
#endif


#if defined (VERTEXSHADER) || ( defined (PIXELSHADER) && !defined(HULLSHADER_PRESENT)) || defined(HULLSHADER)

	BEGIN_STRUCT(V2P_STRUCT)

		V2P_REQUIRED_FIELD

		#if defined(TEXCOORD_TYPE_0)
			TEXCOORD_DECL(TEXCOORD_TYPE_0 TEXCOORD_VAR_NAME_0, TEXCOORD0);
		#endif

		#if defined(TEXCOORD_TYPE_1)
			TEXCOORD_DECL(TEXCOORD_TYPE_1 TEXCOORD_VAR_NAME_1, TEXCOORD1);
		#endif

		#if defined(TEXCOORD_TYPE_2)
			TEXCOORD_DECL(TEXCOORD_TYPE_2 TEXCOORD_VAR_NAME_2, TEXCOORD2);
		#endif

		#if defined(TEXCOORD_TYPE_3)
			TEXCOORD_DECL(TEXCOORD_TYPE_3 TEXCOORD_VAR_NAME_3, TEXCOORD3);
		#endif

		#if defined(TEXCOORD_TYPE_4)
			TEXCOORD_DECL(TEXCOORD_TYPE_4 TEXCOORD_VAR_NAME_4, TEXCOORD4);
		#endif

		#if defined(TEXCOORD_TYPE_5)
			TEXCOORD_DECL(TEXCOORD_TYPE_5 TEXCOORD_VAR_NAME_5, TEXCOORD5);
		#endif

		#if defined(TEXCOORD_TYPE_6)
			TEXCOORD_DECL(TEXCOORD_TYPE_6 TEXCOORD_VAR_NAME_6, TEXCOORD6);
		#endif

		#if defined(TEXCOORD_TYPE_7)
			TEXCOORD_DECL(TEXCOORD_TYPE_7 TEXCOORD_VAR_NAME_7, TEXCOORD7);
		#endif

		#if defined(TEXCOORD_TYPE_8)
			TEXCOORD_DECL(TEXCOORD_TYPE_8 TEXCOORD_VAR_NAME_8, TEXCOORD8);
		#endif

		#if defined(TEXCOORD_TYPE_9)
			TEXCOORD_DECL(TEXCOORD_TYPE_9 TEXCOORD_VAR_NAME_9, TEXCOORD9);
		#endif

		#if defined(TEXCOORD_TYPE_10)
			TEXCOORD_DECL(TEXCOORD_TYPE_10 TEXCOORD_VAR_NAME_10, TEXCOORD10);
		#endif

		#if defined(TEXCOORD_TYPE_11)
			TEXCOORD_DECL(TEXCOORD_TYPE_11 TEXCOORD_VAR_NAME_11, TEXCOORD11);
		#endif

		#if defined(TEXCOORD_TYPE_12)
			TEXCOORD_DECL(TEXCOORD_TYPE_12 TEXCOORD_VAR_NAME_12, TEXCOORD12);
		#endif

		#if defined(TEXCOORD_TYPE_13)
			TEXCOORD_DECL(TEXCOORD_TYPE_13 TEXCOORD_VAR_NAME_13, TEXCOORD13);
		#endif

		#if defined(TEXCOORD_TYPE_14)
			TEXCOORD_DECL(TEXCOORD_TYPE_14 TEXCOORD_VAR_NAME_14, TEXCOORD14);
		#endif

		#if defined(TEXCOORD_TYPE_15)
			TEXCOORD_DECL(TEXCOORD_TYPE_15 TEXCOORD_VAR_NAME_15, TEXCOORD15);
		#endif

		#if defined(VFACE_ON)
			PS_VFACE_FIELD
		#endif

	END_STRUCT

#endif


// DOMAINSHADER

#if defined(DOMAINSHADER)

    #define H2D_STRUCT_NAME inTC
	#define D2P_STRUCT_NAME outTC

    #define T2D_STRUCT_NAME itTES

    #define T2D_STRUCT_NAME_DOT T2D_STRUCT_NAME.

    #define INPUT_STRUCT_NAME H2D_STRUCT_NAME

    #if HULLDOMAIN == 3
        #define DOMAINLOCATION_TYPE float3
    #else
        #define DOMAINLOCATION_TYPE float2
    #endif

	#define DOMAIN_PARAMS DS_PRECISE_DEF T2D_STRUCT T2D_STRUCT_NAME, DS_PRECISE_DEF const OutputPatch< H2D_STRUCT, HULLDOMAIN > H2D_STRUCT_NAME, DOMAINLOCATION_TYPE I_UVD : SV_DOMAINLOCATION, out DS_PRECISE_DEF D2P_STRUCT D2P_STRUCT_NAME

	// input
	#define H2D_STRUCT_NAME_DOT

	// output
	#define D2P_STRUCT_NAME_DOT D2P_STRUCT_NAME.


    #define V_POS_SS_TC D2P_STRUCT_NAME.v_pos_ss

	#define D2P_REQUIRED_FIELD float4 v_pos_ss: SV_POSITION;

    #define H2D_REQUIRED_FIELD float4 v_pos_ws : WORLDPOS;
	//#define V_POS_WS H2D_STRUCT_NAME.v_pos_ws
    #define V_POS_WS(a) H2D_STRUCT_NAME[a].v_pos_ws

    #define PS_VFACE_FIELD


    #if HULLDOMAIN == 3
        #define EDGES_COUNT 3
    #elif HULLDOMAIN == 4
        #define EDGES_COUNT 4
    #else
        #define EDGES_COUNT 2
    #endif

    #define T2D_REQUIRED_FIELD float i_edges[EDGES_COUNT] : SV_TESSFACTOR; float i_inside : SV_INSIDETESSFACTOR;
    #define I_EDGES T2D_STRUCT_NAME.i_edges
    #define I_INSIDE T2D_STRUCT_NAME.i_inside

    #define OUTPUT_SAME_AS_INPUT(a) Output_same_as_input(a, H2D_STRUCT_NAME, T2D_STRUCT_NAME, D2P_STRUCT_NAME)
	#define OUTPUT_SAME_AS_INPUT_PRECISE(a) Output_same_as_input_precise(a, H2D_STRUCT_NAME, T2D_STRUCT_NAME, D2P_STRUCT_NAME)

#endif



#if defined(HULLSHADER) || defined(DOMAINSHADER)

    BEGIN_STRUCT(T2D_STRUCT)

        T2D_REQUIRED_FIELD

		#if defined(TEXCOORD_T2D_TYPE_0)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_0 TEXCOORD_T2D_VAR_NAME_0, TEXCOORD0);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_1)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_1 TEXCOORD_T2D_VAR_NAME_1, TEXCOORD1);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_2)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_2 TEXCOORD_T2D_VAR_NAME_2, TEXCOORD2);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_3)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_3 TEXCOORD_T2D_VAR_NAME_3, TEXCOORD3);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_4)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_4 TEXCOORD_T2D_VAR_NAME_4, TEXCOORD4);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_5)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_5 TEXCOORD_T2D_VAR_NAME_5, TEXCOORD5);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_6)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_6 TEXCOORD_T2D_VAR_NAME_6, TEXCOORD6);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_7)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_7 TEXCOORD_T2D_VAR_NAME_7, TEXCOORD7);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_8)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_8 TEXCOORD_T2D_VAR_NAME_8, TEXCOORD8);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_9)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_9 TEXCOORD_T2D_VAR_NAME_9, TEXCOORD9);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_10)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_10 TEXCOORD_T2D_VAR_NAME_10, TEXCOORD10);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_11)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_11 TEXCOORD_T2D_VAR_NAME_11, TEXCOORD11);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_12)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_12 TEXCOORD_T2D_VAR_NAME_12, TEXCOORD12);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_13)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_13 TEXCOORD_T2D_VAR_NAME_13, TEXCOORD13);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_14)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_14 TEXCOORD_T2D_VAR_NAME_14, TEXCOORD14);
		#endif

		#if defined(TEXCOORD_T2D_TYPE_15)
			TEXCOORD_T2D_DECL(TEXCOORD_T2D_TYPE_15 TEXCOORD_T2D_VAR_NAME_15, TEXCOORD15);
		#endif

	END_STRUCT


	BEGIN_STRUCT(H2D_STRUCT)

		H2D_REQUIRED_FIELD

		#if defined(TEXCOORD_H2D_TYPE_0)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_0 TEXCOORD_H2D_VAR_NAME_0, TEXCOORD0);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_1)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_1 TEXCOORD_H2D_VAR_NAME_1, TEXCOORD1);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_2)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_2 TEXCOORD_H2D_VAR_NAME_2, TEXCOORD2);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_3)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_3 TEXCOORD_H2D_VAR_NAME_3, TEXCOORD3);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_4)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_4 TEXCOORD_H2D_VAR_NAME_4, TEXCOORD4);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_5)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_5 TEXCOORD_H2D_VAR_NAME_5, TEXCOORD5);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_6)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_6 TEXCOORD_H2D_VAR_NAME_6, TEXCOORD6);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_7)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_7 TEXCOORD_H2D_VAR_NAME_7, TEXCOORD7);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_8)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_8 TEXCOORD_H2D_VAR_NAME_8, TEXCOORD8);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_9)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_9 TEXCOORD_H2D_VAR_NAME_9, TEXCOORD9);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_10)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_10 TEXCOORD_H2D_VAR_NAME_10, TEXCOORD10);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_11)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_11 TEXCOORD_H2D_VAR_NAME_11, TEXCOORD11);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_12)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_12 TEXCOORD_H2D_VAR_NAME_12, TEXCOORD12);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_13)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_13 TEXCOORD_H2D_VAR_NAME_13, TEXCOORD13);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_14)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_14 TEXCOORD_H2D_VAR_NAME_14, TEXCOORD14);
		#endif

		#if defined(TEXCOORD_H2D_TYPE_15)
			TEXCOORD_H2D_DECL(TEXCOORD_H2D_TYPE_15 TEXCOORD_H2D_VAR_NAME_15, TEXCOORD15);
		#endif

	END_STRUCT



    #if defined(HULLSHADER)


        void Output_same_as_input(uint pid, InputPatch< V2P_STRUCT, HULLDOMAIN > V2P_STRUCT_NAME, inout H2D_STRUCT H2D_STRUCT_NAME)
        {
            V_POS_OUT_WS = V2P_STRUCT_NAME[pid].v_pos_ws;

            #if defined(HULL_OUT_0) && defined(HULL_IN_0)
                H2D_STRUCT_NAME . HULL_OUT_0 = V2P_STRUCT_NAME[pid].HULL_IN_0;
            #endif

            #if defined(HULL_OUT_1) && defined(HULL_IN_1)
                H2D_STRUCT_NAME . HULL_OUT_1 = V2P_STRUCT_NAME[pid].HULL_IN_1;
            #endif

            #if defined(HULL_OUT_2) && defined(HULL_IN_2)
                H2D_STRUCT_NAME . HULL_OUT_2 = V2P_STRUCT_NAME[pid].HULL_IN_2;
            #endif

            #if defined(HULL_OUT_3) && defined(HULL_IN_3)
                H2D_STRUCT_NAME . HULL_OUT_3 = V2P_STRUCT_NAME[pid].HULL_IN_3;
            #endif

            #if defined(HULL_OUT_4) && defined(HULL_IN_4)
                H2D_STRUCT_NAME . HULL_OUT_4 = V2P_STRUCT_NAME[pid].HULL_IN_4;
            #endif

            #if defined(HULL_OUT_5) && defined(HULL_IN_5)
                H2D_STRUCT_NAME . HULL_OUT_5 = V2P_STRUCT_NAME[pid].HULL_IN_5;
            #endif

            #if defined(HULL_OUT_6) && defined(HULL_IN_6)
                H2D_STRUCT_NAME . HULL_OUT_6 = V2P_STRUCT_NAME[pid].HULL_IN_6;
            #endif

            #if defined(HULL_OUT_7) && defined(HULL_IN_7)
                H2D_STRUCT_NAME . HULL_OUT_7 = V2P_STRUCT_NAME[pid].HULL_IN_7;
            #endif

            #if defined(HULL_OUT_8) && defined(HULL_IN_8)
                H2D_STRUCT_NAME . HULL_OUT_8 = V2P_STRUCT_NAME[pid].HULL_IN_8;
            #endif

            #if defined(HULL_OUT_9) && defined(HULL_IN_9)
                H2D_STRUCT_NAME . HULL_OUT_9 = V2P_STRUCT_NAME[pid].HULL_IN_9;
            #endif

            #if defined(HULL_OUT_10) && defined(HULL_IN_10)
                H2D_STRUCT_NAME . HULL_OUT_10 = V2P_STRUCT_NAME[pid].HULL_IN_10;
            #endif

            #if defined(HULL_OUT_11) && defined(HULL_IN_11)
                H2D_STRUCT_NAME . HULL_OUT_11 = V2P_STRUCT_NAME[pid].HULL_IN_11;
            #endif

            #if defined(HULL_OUT_12) && defined(HULL_IN_12)
                H2D_STRUCT_NAME . HULL_OUT_12 = V2P_STRUCT_NAME[pid].HULL_IN_12;
            #endif

            #if defined(HULL_OUT_13) && defined(HULL_IN_13)
                H2D_STRUCT_NAME . HULL_OUT_13 = V2P_STRUCT_NAME[pid].HULL_IN_13;
            #endif

            #if defined(HULL_OUT_14) && defined(HULL_IN_14)
                H2D_STRUCT_NAME . HULL_OUT_14 = V2P_STRUCT_NAME[pid].HULL_IN_14;
            #endif

            #if defined(HULL_OUT_15) && defined(HULL_IN_15)
                H2D_STRUCT_NAME . HULL_OUT_15 = V2P_STRUCT_NAME[pid].HULL_IN_15;
            #endif

			 #if defined(HULL_OUT_16) && defined(HULL_IN_16)
                H2D_STRUCT_NAME . HULL_OUT_16 = V2P_STRUCT_NAME[pid].HULL_IN_16;
            #endif

            #if defined(HULL_OUT_17) && defined(HULL_IN_17)
                H2D_STRUCT_NAME . HULL_OUT_17 = V2P_STRUCT_NAME[pid].HULL_IN_17;
            #endif

            #if defined(HULL_OUT_18) && defined(HULL_IN_18)
                H2D_STRUCT_NAME . HULL_OUT_18 = V2P_STRUCT_NAME[pid].HULL_IN_18;
            #endif

            #if defined(HULL_OUT_19) && defined(HULL_IN_19)
                H2D_STRUCT_NAME . HULL_OUT_19 = V2P_STRUCT_NAME[pid].HULL_IN_19;
            #endif

            #if defined(HULL_OUT_20) && defined(HULL_IN_20)
                H2D_STRUCT_NAME . HULL_OUT_20 = V2P_STRUCT_NAME[pid].HULL_IN_20;
            #endif

            #if defined(HULL_OUT_21) && defined(HULL_IN_21)
                H2D_STRUCT_NAME . HULL_OUT_21 = V2P_STRUCT_NAME[pid].HULL_IN_21;
            #endif

            #if defined(HULL_OUT_22) && defined(HULL_IN_22)
                H2D_STRUCT_NAME . HULL_OUT_22 = V2P_STRUCT_NAME[pid].HULL_IN_22;
            #endif

            #if defined(HULL_OUT_23) && defined(HULL_IN_23)
                H2D_STRUCT_NAME . HULL_OUT_23 = V2P_STRUCT_NAME[pid].HULL_IN_23;
            #endif

            #if defined(HULL_OUT_24) && defined(HULL_IN_24)
                H2D_STRUCT_NAME . HULL_OUT_24 = V2P_STRUCT_NAME[pid].HULL_IN_24;
            #endif

            #if defined(HULL_OUT_25) && defined(HULL_IN_25)
                H2D_STRUCT_NAME . HULL_OUT_25 = V2P_STRUCT_NAME[pid].HULL_IN_25;
            #endif

			 #if defined(HULL_OUT_26) && defined(HULL_IN_26)
                H2D_STRUCT_NAME . HULL_OUT_26 = V2P_STRUCT_NAME[pid].HULL_IN_26;
            #endif

            #if defined(HULL_OUT_27) && defined(HULL_IN_27)
                H2D_STRUCT_NAME . HULL_OUT_27 = V2P_STRUCT_NAME[pid].HULL_IN_27;
            #endif

            #if defined(HULL_OUT_28) && defined(HULL_IN_28)
                H2D_STRUCT_NAME . HULL_OUT_28 = V2P_STRUCT_NAME[pid].HULL_IN_28;
            #endif

            #if defined(HULL_OUT_29) && defined(HULL_IN_29)
                H2D_STRUCT_NAME . HULL_OUT_29 = V2P_STRUCT_NAME[pid].HULL_IN_29;
            #endif

            #if defined(HULL_OUT_30) && defined(HULL_IN_30)
                H2D_STRUCT_NAME . HULL_OUT_30 = V2P_STRUCT_NAME[pid].HULL_IN_30;
            #endif

            #if defined(HULL_OUT_31) && defined(HULL_IN_31)
                H2D_STRUCT_NAME . HULL_OUT_31 = V2P_STRUCT_NAME[pid].HULL_IN_31;
            #endif
        }

		void Output_same_as_input_precise(uint pid, InputPatch< V2P_STRUCT, HULLDOMAIN > V2P_STRUCT_NAME, precise inout H2D_STRUCT H2D_STRUCT_NAME)
		{
			Output_same_as_input( pid, V2P_STRUCT_NAME, H2D_STRUCT_NAME);
		}

    #endif

#endif


// PIXELSHADER


#if defined(PIXELSHADER) && defined(HULLSHADER_PRESENT)

	#define OUTPUT_STRUCT_NAME_DOT OUTPUT_STRUCT_NAME.

	#define PIX_PARAMS D2P_STRUCT D2P_STRUCT_NAME, out OUTPUT_STRUCT OUTPUT_STRUCT_NAME

	#define D2P_STRUCT_NAME inTC

    #define V2P_STRUCT_NAME_DOT D2P_STRUCT_NAME.
	#define D2P_STRUCT_NAME_DOT D2P_STRUCT_NAME.

	#define V_POS_SS_TC D2P_STRUCT_NAME.v_pos_ss

	#define D2P_REQUIRED_FIELD float4 v_pos_ss: SV_POSITION;
	#define PS_VFACE_FIELD bool f_side_internal: SV_ISFRONTFACE;

	#define gl_FrontFacing (D2P_STRUCT_NAME.f_side_internal)

	#define OUTPUT_STRUCT OUTs
	#define OUTPUT_STRUCT_NAME outputs

    #define SELECT_VD(idx) uv_coord_##idx##_domain

	BEGIN_STRUCT(OUTPUT_STRUCT)

		#if defined (COLOR_OUT_TYPE)
			OUTPUT_COL(COLOR_OUT_TYPE COLOR_OUT_NAME, OUT_COLOR_SEMANTIC(0));
		#endif

		#if defined (COLOR0_OUT_TYPE)
			OUTPUT_COL(COLOR0_OUT_TYPE COLOR0_OUT_NAME, OUT_COLOR_SEMANTIC(0));
		#endif

		#if defined (COLOR1_OUT_TYPE)
			OUTPUT_COL(COLOR1_OUT_TYPE COLOR1_OUT_NAME, OUT_COLOR_SEMANTIC(1));
		#endif

		#if defined (COLOR2_OUT_TYPE)
			OUTPUT_COL(COLOR2_OUT_TYPE COLOR2_OUT_NAME, OUT_COLOR_SEMANTIC(2));
		#endif

		#if defined (COLOR3_OUT_TYPE)
			OUTPUT_COL(COLOR3_OUT_TYPE COLOR3_OUT_NAME, OUT_COLOR_SEMANTIC(3));
		#endif

	END_STRUCT

#endif


#if defined (DOMAINSHADER) || ( defined (PIXELSHADER) && defined(HULLSHADER_PRESENT) )

	BEGIN_STRUCT(D2P_STRUCT)

		D2P_REQUIRED_FIELD

		#if defined(TEXCOORD_D2P_TYPE_0)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_0 TEXCOORD_D2P_VAR_NAME_0, TEXCOORD0);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_1)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_1 TEXCOORD_D2P_VAR_NAME_1, TEXCOORD1);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_2)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_2 TEXCOORD_D2P_VAR_NAME_2, TEXCOORD2);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_3)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_3 TEXCOORD_D2P_VAR_NAME_3, TEXCOORD3);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_4)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_4 TEXCOORD_D2P_VAR_NAME_4, TEXCOORD4);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_5)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_5 TEXCOORD_D2P_VAR_NAME_5, TEXCOORD5);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_6)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_6 TEXCOORD_D2P_VAR_NAME_6, TEXCOORD6);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_7)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_7 TEXCOORD_D2P_VAR_NAME_7, TEXCOORD7);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_8)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_8 TEXCOORD_D2P_VAR_NAME_8, TEXCOORD8);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_9)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_9 TEXCOORD_D2P_VAR_NAME_9, TEXCOORD9);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_10)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_10 TEXCOORD_D2P_VAR_NAME_10, TEXCOORD10);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_11)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_11 TEXCOORD_D2P_VAR_NAME_11, TEXCOORD11);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_12)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_12 TEXCOORD_D2P_VAR_NAME_12, TEXCOORD12);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_13)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_13 TEXCOORD_D2P_VAR_NAME_13, TEXCOORD13);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_14)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_14 TEXCOORD_D2P_VAR_NAME_14, TEXCOORD14);
		#endif

		#if defined(TEXCOORD_D2P_TYPE_15)
			TEXCOORD_D2P_DECL(TEXCOORD_D2P_TYPE_15 TEXCOORD_D2P_VAR_NAME_15, TEXCOORD15);
		#endif

		#if defined(VFACE_ON)
			PS_VFACE_FIELD
		#endif

	END_STRUCT


    #if defined (DOMAINSHADER)


        void Output_same_as_input(DOMAINLOCATION_TYPE uvd, OutputPatch< H2D_STRUCT, HULLDOMAIN > H2D_STRUCT_NAME, T2D_STRUCT T2D_STRUCT_NAME, inout D2P_STRUCT D2P_STRUCT_NAME)
        {
            V_POS_SS_TC = H2D_STRUCT_NAME[0].v_pos_ws * uvd.z + H2D_STRUCT_NAME[1].v_pos_ws * uvd.x + H2D_STRUCT_NAME[2].v_pos_ws * uvd.y;

            #if defined(DOMAIN_OUT_0) && defined(DOMAIN_IN_0)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_0 = H2D_STRUCT_NAME[0].DOMAIN_IN_0 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_0 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_0 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_1) && defined(DOMAIN_IN_1)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_1 = H2D_STRUCT_NAME[0].DOMAIN_IN_1 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_1 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_1 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_2) && defined(DOMAIN_IN_2)
               #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_2 = H2D_STRUCT_NAME[0].DOMAIN_IN_2 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_2 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_2 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_3) && defined(DOMAIN_IN_3)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_3 = H2D_STRUCT_NAME[0].DOMAIN_IN_3 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_3 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_3 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_4) && defined(DOMAIN_IN_4)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_4 = H2D_STRUCT_NAME[0].DOMAIN_IN_4 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_4 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_4 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_5) && defined(DOMAIN_IN_5)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_5 = H2D_STRUCT_NAME[0].DOMAIN_IN_5 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_5 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_5 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_6) && defined(DOMAIN_IN_6)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_6 = H2D_STRUCT_NAME[0].DOMAIN_IN_6 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_6 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_6 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_7) && defined(DOMAIN_IN_7)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_7 = H2D_STRUCT_NAME[0].DOMAIN_IN_7 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_7 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_7 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_8) && defined(DOMAIN_IN_8)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_8 = H2D_STRUCT_NAME[0].DOMAIN_IN_8 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_8 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_8 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_9) && defined(DOMAIN_IN_9)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_9 = H2D_STRUCT_NAME[0].DOMAIN_IN_9 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_9 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_9 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_10) && defined(DOMAIN_IN_10)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_10 = H2D_STRUCT_NAME[0].DOMAIN_IN_10 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_10 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_10 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_11) && defined(DOMAIN_IN_11)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_11 = H2D_STRUCT_NAME[0].DOMAIN_IN_11 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_11 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_11 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_12) && defined(DOMAIN_IN_12)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_12 = H2D_STRUCT_NAME[0].DOMAIN_IN_12 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_12 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_12 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_13) && defined(DOMAIN_IN_13)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_13 = H2D_STRUCT_NAME[0].DOMAIN_IN_13 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_13 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_13 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_14) && defined(DOMAIN_IN_14)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_14 = H2D_STRUCT_NAME[0].DOMAIN_IN_14 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_14 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_14 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_15) && defined(DOMAIN_IN_15)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_15 = H2D_STRUCT_NAME[0].DOMAIN_IN_15 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_15 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_15 * uvd.y;
                #endif
            #endif


			#if defined(DOMAIN_OUT_16) && defined(DOMAIN_IN_16)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_16 = H2D_STRUCT_NAME[0].DOMAIN_IN_16 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_16 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_16 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_17) && defined(DOMAIN_IN_17)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_17 = H2D_STRUCT_NAME[0].DOMAIN_IN_17 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_17 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_17 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_18) && defined(DOMAIN_IN_18)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_18 = H2D_STRUCT_NAME[0].DOMAIN_IN_18 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_18 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_18 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_19) && defined(DOMAIN_IN_19)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_19 = H2D_STRUCT_NAME[0].DOMAIN_IN_19 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_19 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_19 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_20) && defined(DOMAIN_IN_20)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_20 = H2D_STRUCT_NAME[0].DOMAIN_IN_20 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_20 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_20 * uvd.y;
                #endif
            #endif

             #if defined(DOMAIN_OUT_21) && defined(DOMAIN_IN_21)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_21 = H2D_STRUCT_NAME[0].DOMAIN_IN_21 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_21 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_21 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_22) && defined(DOMAIN_IN_22)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_22 = H2D_STRUCT_NAME[0].DOMAIN_IN_22 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_22 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_22 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_23) && defined(DOMAIN_IN_23)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_23 = H2D_STRUCT_NAME[0].DOMAIN_IN_23 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_23 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_23 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_24) && defined(DOMAIN_IN_24)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_24 = H2D_STRUCT_NAME[0].DOMAIN_IN_24 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_24 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_24 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_25) && defined(DOMAIN_IN_25)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_25 = H2D_STRUCT_NAME[0].DOMAIN_IN_25 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_25 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_25 * uvd.y;
                #endif
            #endif


			#if defined(DOMAIN_OUT_26) && defined(DOMAIN_IN_26)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_26 = H2D_STRUCT_NAME[0].DOMAIN_IN_26 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_26 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_26 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_27) && defined(DOMAIN_IN_27)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_27 = H2D_STRUCT_NAME[0].DOMAIN_IN_27 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_27 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_27 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_28) && defined(DOMAIN_IN_28)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_28 = H2D_STRUCT_NAME[0].DOMAIN_IN_28 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_28 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_28 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_29) && defined(DOMAIN_IN_29)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_29 = H2D_STRUCT_NAME[0].DOMAIN_IN_29 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_29 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_29 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_30) && defined(DOMAIN_IN_30)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_30 = H2D_STRUCT_NAME[0].DOMAIN_IN_30 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_30 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_30 * uvd.y;
                #endif
            #endif

            #if defined(DOMAIN_OUT_31) && defined(DOMAIN_IN_31)
                #if DOMAINLOCATION_TYPE == float3
                    DOMAIN_OUT_31 = H2D_STRUCT_NAME[0].DOMAIN_IN_31 * uvd.z + H2D_STRUCT_NAME[1].DOMAIN_IN_31 * uvd.x + H2D_STRUCT_NAME[2].DOMAIN_IN_31 * uvd.y;
                #endif
            #endif
        }

		void Output_same_as_input_precise(DOMAINLOCATION_TYPE uvd, OutputPatch< H2D_STRUCT, HULLDOMAIN > H2D_STRUCT_NAME, T2D_STRUCT T2D_STRUCT_NAME, precise inout D2P_STRUCT D2P_STRUCT_NAME)
		{
			Output_same_as_input(uvd, H2D_STRUCT_NAME, T2D_STRUCT_NAME, D2P_STRUCT_NAME);
		}
    #endif

#endif


// DOMAINSHADER samplers
#if defined(DOMAINSHADER)

	#if defined(TEXTURE_DS_NAME_0)
		uniform TEXTURE_DS_TYPE_0 TEXTURE_DS_NAME_0;
	#endif

	#if defined(SAMPLER_DS_NAME_0)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_0 SAMPLER_DS_NAME_0, 0);
	#endif

	#if defined(TEXTURE_DS_NAME_1)
		uniform TEXTURE_DS_TYPE_1 TEXTURE_DS_NAME_1;
	#endif

	#if defined(SAMPLER_DS_NAME_1)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_1 SAMPLER_DS_NAME_1, 1);
	#endif

	#if defined(TEXTURE_DS_NAME_2)
		uniform TEXTURE_DS_TYPE_2 TEXTURE_DS_NAME_2;
	#endif

	#if defined(SAMPLER_DS_NAME_2)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_2 SAMPLER_DS_NAME_2, 2);
	#endif

	#if defined(TEXTURE_DS_NAME_3)
		uniform TEXTURE_DS_TYPE_3 TEXTURE_DS_NAME_3;
	#endif

	#if defined(SAMPLER_DS_NAME_3)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_3 SAMPLER_DS_NAME_3, 3);
	#endif

	#if defined(TEXTURE_DS_NAME_4)
		uniform TEXTURE_DS_TYPE_4 TEXTURE_DS_NAME_4;
	#endif

	#if defined(SAMPLER_DS_NAME_4)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_4 SAMPLER_DS_NAME_4, 4);
	#endif

	#if defined(TEXTURE_DS_NAME_5)
		uniform TEXTURE_DS_TYPE_5 TEXTURE_DS_NAME_5;
	#endif

	#if defined(SAMPLER_DS_NAME_5)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_5 SAMPLER_DS_NAME_5, 5);
	#endif

	#if defined(TEXTURE_DS_NAME_6)
		uniform TEXTURE_DS_TYPE_6 TEXTURE_DS_NAME_6;
	#endif

	#if defined(SAMPLER_DS_NAME_6)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_6 SAMPLER_DS_NAME_6, 6);
	#endif

	#if defined(TEXTURE_DS_NAME_7)
		uniform TEXTURE_DS_TYPE_7 TEXTURE_DS_NAME_7;
	#endif

	#if defined(SAMPLER_DS_NAME_7)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_7 SAMPLER_DS_NAME_7, 7);
	#endif

	#if defined(TEXTURE_DS_NAME_8)
		uniform TEXTURE_DS_TYPE_8 TEXTURE_DS_NAME_8;
	#endif

	#if defined(SAMPLER_DS_NAME_8)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_8 SAMPLER_DS_NAME_8, 8);
	#endif

	#if defined(TEXTURE_DS_NAME_9)
		uniform TEXTURE_DS_TYPE_9 TEXTURE_DS_NAME_9;
	#endif

	#if defined(SAMPLER_DS_NAME_9)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_9 SAMPLER_DS_NAME_9, 9);
	#endif

	#if defined(TEXTURE_DS_NAME_10)
		uniform TEXTURE_DS_TYPE_10 TEXTURE_DS_NAME_10;
	#endif

	#if defined(SAMPLER_DS_NAME_10)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_10 SAMPLER_DS_NAME_10, 10);
	#endif

	#if defined(TEXTURE_DS_NAME_11)
		uniform TEXTURE_DS_TYPE_11 TEXTURE_DS_NAME_11;
	#endif

	#if defined(SAMPLER_DS_NAME_11)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_11 SAMPLER_DS_NAME_11, 11);
	#endif

	#if defined(TEXTURE_DS_NAME_12)
		uniform TEXTURE_DS_TYPE_12 TEXTURE_DS_NAME_12;
	#endif

	#if defined(SAMPLER_DS_NAME_12)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_12 SAMPLER_DS_NAME_12, 12);
	#endif

	#if defined(TEXTURE_DS_NAME_13)
		uniform TEXTURE_DS_TYPE_13 TEXTURE_DS_NAME_13;
	#endif

	#if defined(SAMPLER_DS_NAME_13)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_13 SAMPLER_DS_NAME_13, 13);
	#endif

	#if defined(TEXTURE_DS_NAME_14)
		uniform TEXTURE_DS_TYPE_14 TEXTURE_DS_NAME_14;
	#endif

	#if defined(SAMPLER_DS_NAME_14)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_14 SAMPLER_DS_NAME_14, 14);
	#endif

	#if defined(TEXTURE_DS_NAME_15)
		uniform TEXTURE_DS_TYPE_15 TEXTURE_DS_NAME_15;
	#endif

	#if defined(SAMPLER_DS_NAME_15)
		SAMPLER_DS_DECL(SAMPLER_DS_TYPE_15 SAMPLER_DS_NAME_15, 15);
	#endif

#endif


// HULLSHADER samplers
#if defined (HULLSHADER)

	#if defined(TEXTURE_HS_NAME_0)
		uniform TEXTURE_HS_TYPE_0 TEXTURE_HS_NAME_0;
	#endif

	#if defined(SAMPLER_HS_NAME_0)
			SAMPLER_HS_DECL(SAMPLER_HS_TYPE_0 SAMPLER_HS_NAME_0, 0);
	#endif

	#if defined(TEXTURE_HS_NAME_1)
		uniform TEXTURE_HS_TYPE_1 TEXTURE_HS_NAME_1;
	#endif

	#if defined(SAMPLER_HS_NAME_1)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_1 SAMPLER_HS_NAME_1, 1);
	#endif

	#if defined(TEXTURE_HS_NAME_2)
		uniform TEXTURE_HS_TYPE_2 TEXTURE_HS_NAME_2;
	#endif

	#if defined(SAMPLER_HS_NAME_2)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_2 SAMPLER_HS_NAME_2, 2);
	#endif

	#if defined(TEXTURE_HS_NAME_3)
		uniform TEXTURE_HS_TYPE_3 TEXTURE_HS_NAME_3;
	#endif

	#if defined(SAMPLER_HS_NAME_3)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_3 SAMPLER_HS_NAME_3, 3);
	#endif

	#if defined(TEXTURE_HS_NAME_4)
		uniform TEXTURE_HS_TYPE_4 TEXTURE_HS_NAME_4;
	#endif

	#if defined(SAMPLER_HS_NAME_4)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_4 SAMPLER_HS_NAME_4, 4);
	#endif

	#if defined(TEXTURE_HS_NAME_5)
		uniform TEXTURE_HS_TYPE_5 TEXTURE_HS_NAME_5;
	#endif

	#if defined(SAMPLER_HS_NAME_5)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_5 SAMPLER_HS_NAME_5, 5);
	#endif

	#if defined(TEXTURE_HS_NAME_6)
		uniform TEXTURE_HS_TYPE_6 TEXTURE_HS_NAME_6;
	#endif

	#if defined(SAMPLER_HS_NAME_6)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_6 SAMPLER_HS_NAME_6, 6);
	#endif

	#if defined(TEXTURE_HS_NAME_7)
		uniform TEXTURE_HS_TYPE_7 TEXTURE_HS_NAME_7;
	#endif

	#if defined(SAMPLER_HS_NAME_7)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_7 SAMPLER_HS_NAME_7, 7);
	#endif

	#if defined(TEXTURE_HS_NAME_8)
		uniform TEXTURE_HS_TYPE_8 TEXTURE_HS_NAME_8;
	#endif

	#if defined(SAMPLER_HS_NAME_8)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_8 SAMPLER_HS_NAME_8, 8);
	#endif

	#if defined(TEXTURE_HS_NAME_9)
		uniform TEXTURE_HS_TYPE_9 TEXTURE_HS_NAME_9;
	#endif

	#if defined(SAMPLER_HS_NAME_9)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_9 SAMPLER_HS_NAME_9, 9);
	#endif

	#if defined(TEXTURE_HS_NAME_10)
		uniform TEXTURE_HS_TYPE_10 TEXTURE_HS_NAME_10;
	#endif

	#if defined(SAMPLER_HS_NAME_10)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_10 SAMPLER_HS_NAME_10, 10);
	#endif

	#if defined(TEXTURE_HS_NAME_11)
		uniform TEXTURE_HS_TYPE_11 TEXTURE_HS_NAME_11;
	#endif

	#if defined(SAMPLER_HS_NAME_11)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_11 SAMPLER_HS_NAME_11, 11);
	#endif

	#if defined(TEXTURE_HS_NAME_12)
		uniform TEXTURE_HS_TYPE_12 TEXTURE_HS_NAME_12;
	#endif

	#if defined(SAMPLER_HS_NAME_12)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_12 SAMPLER_HS_NAME_12, 12);
	#endif

	#if defined(TEXTURE_HS_NAME_13)
		uniform TEXTURE_HS_TYPE_13 TEXTURE_HS_NAME_13;
	#endif

	#if defined(SAMPLER_HS_NAME_13)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_13 SAMPLER_HS_NAME_13, 13);
	#endif

	#if defined(TEXTURE_HS_NAME_14)
		uniform TEXTURE_HS_TYPE_14 TEXTURE_HS_NAME_14;
	#endif

	#if defined(SAMPLER_HS_NAME_14)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_14 SAMPLER_HS_NAME_14, 14);
	#endif

	#if defined(TEXTURE_HS_NAME_15)
		uniform TEXTURE_HS_TYPE_15 TEXTURE_HS_NAME_15;
	#endif

	#if defined(SAMPLER_HS_NAME_15)
		SAMPLER_HS_DECL(SAMPLER_HS_TYPE_15 SAMPLER_HS_NAME_15, 15);
	#endif

#endif


// PIXELSHADER samplers
#if defined (PIXELSHADER)

	#if defined(TEXTURE_NAME_0)
		uniform TEXTURE_TYPE_0 TEXTURE_NAME_0;
	#endif

    #if defined(SAMPLER_NAME_0)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_0 PRAGMA_0
        #endif

        #if defined(SAMPLER_TYPE_0)
			SAMPLER_DECL(SAMPLER_TYPE_0 SAMPLER_NAME_0, 0);
        #endif
    #endif

    #if defined(TEXTURE_NAME_1)
		uniform TEXTURE_TYPE_1 TEXTURE_NAME_1;
	#endif

    #if defined(SAMPLER_NAME_1)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_1 PRAGMA_1
        #endif

        #if defined(SAMPLER_TYPE_1)
			SAMPLER_DECL(SAMPLER_TYPE_1 SAMPLER_NAME_1, 1);
		#endif

    #endif

    #if defined(TEXTURE_NAME_2)
		uniform TEXTURE_TYPE_2 TEXTURE_NAME_2;
	#endif

    #if defined(SAMPLER_NAME_2)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_2 PRAGMA_2
        #endif
        #if defined(SAMPLER_TYPE_2)
			SAMPLER_DECL(SAMPLER_TYPE_2 SAMPLER_NAME_2, 2);
		#endif
    #endif

	#if defined(TEXTURE_NAME_3)
		uniform TEXTURE_TYPE_3 TEXTURE_NAME_3;
	#endif

    #if defined(SAMPLER_NAME_3)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_3 PRAGMA_3
        #endif
        #if defined(SAMPLER_TYPE_3)
			SAMPLER_DECL(SAMPLER_TYPE_3 SAMPLER_NAME_3, 3);
		#endif
    #endif

    #if defined(TEXTURE_NAME_4)
		uniform TEXTURE_TYPE_4 TEXTURE_NAME_4;
	#endif

    #if defined(SAMPLER_NAME_4)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_4 PRAGMA_4
        #endif
        #if defined(SAMPLER_TYPE_4)
			SAMPLER_DECL(SAMPLER_TYPE_4 SAMPLER_NAME_4, 4);
		#endif
    #endif

    #if defined(TEXTURE_NAME_5)
		uniform TEXTURE_TYPE_5 TEXTURE_NAME_5;
	#endif

    #if defined(SAMPLER_NAME_5)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_5 PRAGMA_5
        #endif
        #if defined(SAMPLER_TYPE_5)
			SAMPLER_DECL(SAMPLER_TYPE_5 SAMPLER_NAME_5, 5);
		#endif
    #endif

    #if defined(TEXTURE_NAME_6)
		uniform TEXTURE_TYPE_6 TEXTURE_NAME_6;
	#endif

    #if defined(SAMPLER_NAME_6)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_6 PRAGMA_6
        #endif
        #if defined(SAMPLER_TYPE_6)
			SAMPLER_DECL(SAMPLER_TYPE_6 SAMPLER_NAME_6, 6);
		#endif
    #endif

    #if defined(TEXTURE_NAME_7)
		uniform TEXTURE_TYPE_7 TEXTURE_NAME_7;
	#endif

    #if defined(SAMPLER_NAME_7)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_7 PRAGMA_7
        #endif
        #if defined(SAMPLER_TYPE_7)
			SAMPLER_DECL(SAMPLER_TYPE_7 SAMPLER_NAME_7, 7);
		#endif
    #endif

    #if defined(TEXTURE_NAME_8)
		uniform TEXTURE_TYPE_8 TEXTURE_NAME_8;
	#endif

    #if defined(SAMPLER_NAME_8)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_8 PRAGMA_8
        #endif
        #if defined(SAMPLER_TYPE_8)
			SAMPLER_DECL(SAMPLER_TYPE_8 SAMPLER_NAME_8, 8);
		#endif
    #endif

    #if defined(TEXTURE_NAME_9)
		uniform TEXTURE_TYPE_9 TEXTURE_NAME_9;
	#endif

    #if defined(SAMPLER_NAME_9)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_9 PRAGMA_9
        #endif
        #if defined(SAMPLER_TYPE_9)
			SAMPLER_DECL(SAMPLER_TYPE_9 SAMPLER_NAME_9, 9);
		#endif
    #endif

    #if defined(TEXTURE_NAME_10)
		uniform TEXTURE_TYPE_10 TEXTURE_NAME_10;
	#endif

    #if defined(SAMPLER_NAME_10)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_10 PRAGMA_10
        #endif
        #if defined(SAMPLER_TYPE_10)
			SAMPLER_DECL(SAMPLER_TYPE_10 SAMPLER_NAME_10, 10);
		#endif
    #endif

    #if defined(TEXTURE_NAME_11)
		uniform TEXTURE_TYPE_11 TEXTURE_NAME_11;
	#endif

    #if defined(SAMPLER_NAME_11)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_11 PRAGMA_11
        #endif
        #if defined(SAMPLER_TYPE_11)
			SAMPLER_DECL(SAMPLER_TYPE_11 SAMPLER_NAME_11, 11);
		#endif
    #endif

    #if defined(TEXTURE_NAME_12)
		uniform TEXTURE_TYPE_12 TEXTURE_NAME_12;
	#endif

    #if defined(SAMPLER_NAME_12)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_12 PRAGMA_12
        #endif
        #if defined(SAMPLER_TYPE_12)
			SAMPLER_DECL(SAMPLER_TYPE_12 SAMPLER_NAME_12, 12);
		#endif
    #endif

    #if defined(TEXTURE_NAME_13)
		uniform TEXTURE_TYPE_13 TEXTURE_NAME_13;
	#endif

    #if defined(SAMPLER_NAME_13)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_13 PRAGMA_13
        #endif
        #if defined(SAMPLER_TYPE_13)
			SAMPLER_DECL(SAMPLER_TYPE_13 SAMPLER_NAME_13, 13);
		#endif
    #endif

    #if defined(TEXTURE_NAME_14)
		uniform TEXTURE_TYPE_14 TEXTURE_NAME_14;
	#endif

    #if defined(SAMPLER_NAME_14)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_14 PRAGMA_14
        #endif
        #if defined(SAMPLER_TYPE_14)
			SAMPLER_DECL(SAMPLER_TYPE_14 SAMPLER_NAME_14, 14);
		#endif
    #endif

    #if defined(TEXTURE_NAME_15)
		uniform TEXTURE_TYPE_15 TEXTURE_NAME_15;
	#endif

    #if defined(SAMPLER_NAME_15)
        #if defined(SHADER_PATH_PS3)
            #pragma texformat SAMPLER_NAME_15 PRAGMA_15
        #endif
        #if defined(SAMPLER_TYPE_15)
			SAMPLER_DECL(SAMPLER_TYPE_15 SAMPLER_NAME_15, 15);
		#endif
    #endif

#endif


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#if defined(COMPUTESHADER)

		#if defined(TEXTURE_CS_NAME_0)
			uniform TEXTURE_CS_TYPE_0 TEXTURE_CS_NAME_0;
		#endif

		#if defined(SAMPLER_CS_NAME_0)
				SAMPLER_CS_DECL(SAMPLER_CS_TYPE_0 SAMPLER_CS_NAME_0, 0);
		#endif

		#if defined(TEXTURE_CS_NAME_1)
			uniform TEXTURE_CS_TYPE_1 TEXTURE_CS_NAME_1;
		#endif

		#if defined(SAMPLER_CS_NAME_1)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_1 SAMPLER_CS_NAME_1, 1);
		#endif

		#if defined(TEXTURE_CS_NAME_2)
			uniform TEXTURE_CS_TYPE_2 TEXTURE_CS_NAME_2;
		#endif

		#if defined(SAMPLER_CS_NAME_2)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_2 SAMPLER_CS_NAME_2, 2);
		#endif

		#if defined(TEXTURE_CS_NAME_3)
			uniform TEXTURE_CS_TYPE_3 TEXTURE_CS_NAME_3;
		#endif

		#if defined(SAMPLER_CS_NAME_3)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_3 SAMPLER_CS_NAME_3, 3);
		#endif

		#if defined(TEXTURE_CS_NAME_4)
			uniform TEXTURE_CS_TYPE_4 TEXTURE_CS_NAME_4;
		#endif

		#if defined(SAMPLER_CS_NAME_4)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_4 SAMPLER_CS_NAME_4, 4);
		#endif

		#if defined(TEXTURE_CS_NAME_5)
			uniform TEXTURE_CS_TYPE_5 TEXTURE_CS_NAME_5;
		#endif

		#if defined(SAMPLER_CS_NAME_5)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_5 SAMPLER_CS_NAME_5, 5);
		#endif

		#if defined(TEXTURE_CS_NAME_6)
			uniform TEXTURE_CS_TYPE_6 TEXTURE_CS_NAME_6;
		#endif

		#if defined(SAMPLER_CS_NAME_6)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_6 SAMPLER_CS_NAME_6, 6);
		#endif

		#if defined(TEXTURE_CS_NAME_7)
			uniform TEXTURE_CS_TYPE_7 TEXTURE_CS_NAME_7;
		#endif

		#if defined(SAMPLER_CS_NAME_7)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_7 SAMPLER_CS_NAME_7, 7);
		#endif

		#if defined(TEXTURE_CS_NAME_8)
			uniform TEXTURE_CS_TYPE_8 TEXTURE_CS_NAME_8;
		#endif

		#if defined(SAMPLER_CS_NAME_8)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_8 SAMPLER_CS_NAME_8, 8);
		#endif

		#if defined(TEXTURE_CS_NAME_9)
			uniform TEXTURE_CS_TYPE_9 TEXTURE_CS_NAME_9;
		#endif

		#if defined(SAMPLER_CS_NAME_9)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_9 SAMPLER_CS_NAME_9, 9);
		#endif

		#if defined(TEXTURE_CS_NAME_10)
			uniform TEXTURE_CS_TYPE_10 TEXTURE_CS_NAME_10;
		#endif

		#if defined(SAMPLER_CS_NAME_10)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_10 SAMPLER_CS_NAME_10, 10);
		#endif

		#if defined(TEXTURE_CS_NAME_11)
			uniform TEXTURE_CS_TYPE_11 TEXTURE_CS_NAME_11;
		#endif

		#if defined(SAMPLER_CS_NAME_11)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_11 SAMPLER_CS_NAME_11, 11);
		#endif

		#if defined(TEXTURE_CS_NAME_12)
			uniform TEXTURE_CS_TYPE_12 TEXTURE_CS_NAME_12;
		#endif

		#if defined(SAMPLER_CS_NAME_12)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_12 SAMPLER_CS_NAME_12, 12);
		#endif

		#if defined(TEXTURE_CS_NAME_13)
			uniform TEXTURE_CS_TYPE_13 TEXTURE_CS_NAME_13;
		#endif

		#if defined(SAMPLER_CS_NAME_13)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_13 SAMPLER_CS_NAME_13, 13);
		#endif

		#if defined(TEXTURE_CS_NAME_14)
			uniform TEXTURE_CS_TYPE_14 TEXTURE_CS_NAME_14;
		#endif

		#if defined(SAMPLER_CS_NAME_14)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_14 SAMPLER_CS_NAME_14, 14);
		#endif

		#if defined(TEXTURE_CS_NAME_15)
			uniform TEXTURE_CS_TYPE_15 TEXTURE_CS_NAME_15;
		#endif

		#if defined(SAMPLER_CS_NAME_15)
			SAMPLER_CS_DECL(SAMPLER_CS_TYPE_15 SAMPLER_CS_NAME_15, 15);
		#endif

#endif

//auto includes
#if defined (PIXELSHADER)
	#if defined(D_SHADOWS_ON)
		#include <shadows.hlsl>
	#endif
	#if defined(D_DEPTH_TMU_ON)
		#include <depth_sample.hlsl>
	#endif
#endif
