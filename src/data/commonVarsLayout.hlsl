#if !defined(__COMMON_BUFFERS_LAYOUT_INCLUDED)
	
	/* 	
	buffers layout must match engine code, check CRenderContext::UpdateCommonVars_PerFrame
	leave cb0 & cb1 for $Globals (present) & $Params (not present right now) - cb0 vars are reflected and collected into rpacks
	rarely used or hi-freq data should go to cb0 (mostly Technique CONST) without cbuffer declaration (size vary)
	when changing layout, always remember to place mostly used data at the front of cbuffer (sort) - this will utilize constant cache efficiently
	for questions: tszalkowski @ engine room
	
	needs to be updated/checked after making any hlsl layout changes:
	CRenderContext::UpdateCommonVars_PerFrame()
	CRenderContext::UpdateCommonVars_PerModelMtx()
	CShaderCompilerX360::_IsCommonShaderVariable()
	RendererAPI::RDrawInstancing()
	CPs3ShaderCompiler::PrepareSCI()
	CPs3ShaderCompiler::_IsCommonShaderVariable()
	*/
	
	#include <defines.hlsl>
	
#if defined(SHADER_PATH_DX1x)
	#if defined(SHADER_PATH_ORBIS)
		#define CONSTBUF ConstantBuffer
	#else
		#define CONSTBUF cbuffer
	#endif
	
	// update per new frame, render target or camera change
	CONSTBUF perFrameRTViewData : register( b2 )
	{
		float4 VIEWPROJ_XFORM[4]					: packoffset( c0 ); // 0,1,2,3
		float4 VIEW_XFORM[3]						: packoffset( c4 ); // 4,5,6
		float4 RENDER_TARGET_PARAMS_BIAS			: packoffset( c7 ); // 7
		float4 INV_FRUSTUM[2]						: packoffset( c8 ); // 8,9     *** check ps3 common.hlsl ***
		float4 INVVIEW_XFORM[3]						: packoffset( c10 ); //	10,11,12
		float4 CAMERA_POS_WS						: packoffset( c13 ); // 13
		float4 RENDER_TARGET_PARAMS					: packoffset( c14 ); // 14
		float4 POS_2D								: packoffset( c15 ); // 15
		float TIME									: packoffset( c16 ); // 16
		float4 VIEWPORT								: packoffset( c17 ); // 17
		float4 HSM_XFORM_ES_0[3]					: packoffset( c18 ); // 18,19,20
		float4 HSM_XFORM_ES_1[3]					: packoffset( c21 ); // 21,22,23
		float4 HSM_XFORM_ES_2[3]					: packoffset( c24 ); // 24,25,26
		float4 HSM_XFORM_ES_3[3]					: packoffset( c27 ); // 27,28,29	
		float4 PROJECTION_XFORM[4] 					: packoffset( c30 ); // 30,31,32,33
		float4 SUN_DIR_ES							: packoffset( c34 ); // 34
	}

	// update per model mtx change
	CONSTBUF perModelMtxData : register( b3 )
	{
		float4 MODEL_XFORM[3]						: packoffset( c0 ); // 0,1,2,3
	}

	// update per const palette change (currently skinning) - separate buffer is used to prevent cb0 extend
	// sync with skinning.hlsl
	#if ( defined(SKINNING) || defined(SKINNING_ONE_BONE) ) && defined(VERTEXBLENDING_CONSTNUM)
		#if !defined(MTX_PER_BONE)
			#define MTX_PER_BONE 2
		#endif
		
		CONSTBUF perConstPaletteData : register( b4 )
		{
			float4 CONST_PALETTE[VERTEXBLENDING_CONSTNUM * MTX_PER_BONE];
		}
	#endif
	
	// sync with RendererAPI::RDrawInstancing register idx
	#define INSTANCE_DATA_REGISTER 0

#elif defined(SHADER_PATH_OPENGL)
	// BEGIN OF OPENGL--------------------------------------------------------
	
	// update per new frame, render target or camera change
$if defined(OPENGL_LAYOUT_BINDING)
	layout(std140, binding=2) uniform perFrameRTViewData
$else
	layout(std140) uniform perFrameRTViewData
$endif
	{
		float4 VIEWPROJ_XFORM[4];
		float4 VIEW_XFORM[3];
		float4 RENDER_TARGET_PARAMS_BIAS;
		float4 INV_FRUSTUM[2];
		float4 INVVIEW_XFORM[3];
		float4 CAMERA_POS_WS;
		float4 RENDER_TARGET_PARAMS;
		float4 POS_2D;
		float4 PATCH_1TIME;
		float4 VIEWPORT;
		float4 HSM_XFORM_ES_0[3];
		float4 HSM_XFORM_ES_1[3];
		float4 HSM_XFORM_ES_2[3];
		float4 HSM_XFORM_ES_3[3];
		float4 PROJECTION_XFORM[4];
		float4 SUN_DIR_ES;
	};
	float TIME = PATCH_1TIME.x;

	// update per model mtx change
$if defined(OPENGL_LAYOUT_BINDING)
	layout(std140, binding=3) uniform perModelMtxData
$else
	layout(std140) uniform perModelMtxData
$endif
	{
		float4 MODEL_XFORM[3];
	};
	
	// update per const palette change (currently skinning) - separate buffer is used to prevent cb0 extend
	// sync with skinning.hlsl
	#if ( defined(SKINNING) || defined(SKINNING_ONE_BONE) ) && defined(VERTEXBLENDING_CONSTNUM)
		#if !defined(MTX_PER_BONE)
			#define MTX_PER_BONE 2
		#endif
		
	$if defined(OPENGL_LAYOUT_BINDING)
		layout(std140, binding=4) uniform perConstPaletteData
	$else
		layout(std140) uniform perConstPaletteData
	$endif
		{
			float4 CONST_PALETTE[VERTEXBLENDING_CONSTNUM * MTX_PER_BONE];
		};
	#endif
	
		// sync with RendererAPI::RDrawInstancing register idx
	#define INSTANCE_DATA_REGISTER 16
	// END OF OPENGL--------------------------------------------------------
#else

	// we lack some registers on ~dx9 hw, so disable commonVars when skinning is used
	#if ( ( !defined(SKINNING) && !defined(SKINNING_ONE_BONE) ) || !defined(VERTEXBLENDING_CONSTNUM) )
		#define USE_LAYOUT 1
	#else
		#define USE_LAYOUT 0
	#endif

	// sync with skinning.hlsl
	#if ( defined(SKINNING) || defined(SKINNING_ONE_BONE) ) && defined(VERTEXBLENDING_CONSTNUM)
		#if !defined(MTX_PER_BONE)
			#define MTX_PER_BONE 1
		#endif
		CONST_DECL(float4 CONST_PALETTE[VERTEXBLENDING_CONSTNUM * MTX_PER_BONE], 0);
	#endif
	
	// update per model mtx change - does not need any special treatment, let it be processed with std path (like CONSTs)
	uniform float4 MODEL_XFORM[3];
	
	
	#if !defined(PS3_VERTEX_SHADER)	&& !defined(PS3_FRAGMENT_SHADER)	
		// XBOX
	
		#if USE_LAYOUT
			#if SHADER_PATH_WIIU
				#define packoffset(n)
			#else
				#define packoffset(n) : register(##n)
			#endif
		#else
			#define packoffset(n)
		#endif

		// update per new frame, render target or camera change
		uniform float4 VIEWPROJ_XFORM[4]					packoffset( c0 ); // 0,1,2,3
		uniform float4 VIEW_XFORM[3]						packoffset( c4 ); // 4,5,6
		uniform float4 RENDER_TARGET_PARAMS_BIAS			packoffset( c7 ); // 7
		uniform float4 INV_FRUSTUM[2]						packoffset( c8 ); // 8,9     *** check ps3 common.hlsl ***
		uniform float4 INVVIEW_XFORM[3]						packoffset( c10 ); //	10,11,12
		uniform float4 CAMERA_POS_WS						packoffset( c13 ); // 13
		uniform float4 RENDER_TARGET_PARAMS					packoffset( c14 ); // 14
		uniform float4 POS_2D								packoffset( c15 ); // 15
		uniform float TIME									packoffset( c16 ); // 16
		uniform float4 VIEWPORT								packoffset( c17 ); // 17
		uniform float4 HSM_XFORM_ES_0[3]					packoffset( c18 ); // 18,19,20
		uniform float4 HSM_XFORM_ES_1[3]					packoffset( c21 ); // 21,22,23
		uniform float4 HSM_XFORM_ES_2[3]					packoffset( c24 ); // 24,25,26
		uniform float4 HSM_XFORM_ES_3[3]					packoffset( c27 ); // 27,28,29	
		uniform float4 PROJECTION_XFORM[4] 					packoffset( c30 ); // 30,31,32,33
		uniform float4 SUN_DIR_ES							packoffset( c34 ); // 34

		#undef packoffset
		
		// sync with RendererAPI::RDrawInstancing register idx
		#define INSTANCE_DATA_REGISTER 48
		
	#else
		// PS3
		// disable commonVars @ PS3 pixel shader due to shader patching (PS3_FRAGMENT_SHADER defined in PrepareSCI())
		
		#if defined(PS3_FRAGMENT_SHADER)
			#undef USE_LAYOUT
			#define USE_LAYOUT 0
		#endif
		
		#if USE_LAYOUT
			uniform float4 VIEWPROJ_XFORM[4]					:c0; // 0,1,2,3
			uniform float4 VIEW_XFORM[3]						:c4; // 4,5,6
			uniform float4 INV_FRUSTUM0							:c7; // 7     *** check ps3 common.hlsl ***
			uniform float4 INV_FRUSTUM1							:c8; // 8     *** check ps3 common.hlsl ***
			uniform float4 INVVIEW_XFORM[3]						:c9; //	9,10,11
			uniform float4 CAMERA_POS_WS						:c12; // 12
			uniform float4 RENDER_TARGET_PARAMS					:c13; // 13
			uniform float4 POS_2D								:c14; // 14
			uniform float TIME									:c15; // 15
			uniform float4 VIEWPORT								:c16; // 16
			uniform float4 PROJECTION_XFORM[4] 					:c17; // 17,18,19,20
			uniform float4 SUN_DIR_ES							:c21; // 21
			
			// used by PS so leave them alone
			uniform float4 RENDER_TARGET_PARAMS_BIAS;	
			uniform float4 HSM_XFORM_ES_0[3];			
			uniform float4 HSM_XFORM_ES_1[3];		
			uniform float4 HSM_XFORM_ES_2[3];			
			uniform float4 HSM_XFORM_ES_3[3];	
		#else
			uniform float4 VIEWPROJ_XFORM[4];			
			uniform float4 VIEW_XFORM[3];				
			uniform float4 RENDER_TARGET_PARAMS_BIAS;	
			uniform float4 INV_FRUSTUM0;
			uniform float4 INV_FRUSTUM1;				
			uniform float4 INVVIEW_XFORM[3];				
			uniform float4 CAMERA_POS_WS;				
			uniform float4 RENDER_TARGET_PARAMS;			
			uniform float4 POS_2D;						
			uniform float TIME;							
			uniform float4 VIEWPORT;						
			uniform float4 HSM_XFORM_ES_0[3];			
			uniform float4 HSM_XFORM_ES_1[3];		
			uniform float4 HSM_XFORM_ES_2[3];			
			uniform float4 HSM_XFORM_ES_3[3];			
			uniform float4 PROJECTION_XFORM[4]; 			
			uniform float4 SUN_DIR_ES;					
		#endif
		
		// sync with RendererAPI::RDrawInstancing register idx
		#define INSTANCE_DATA_REGISTER 22
		
	#endif

#endif  



#define __COMMON_BUFFERS_LAYOUT_INCLUDED 1

#endif