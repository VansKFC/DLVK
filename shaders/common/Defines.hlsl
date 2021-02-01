
#if !defined(DEFINES_INCLUDED)		
	
	#if defined(SHADER_PATH_OPENGL)
		#include<glsl_attributes.hlsl>		
	
		#define float2 vec2
		#define float3 vec3	
		#define float4 vec4	
		#define half4 vec4
		#define half3 vec3
		#define half2 vec2
		#define half float	
		
		#define bool2 bvec2
		#define bool3 bvec3
		#define bool4 bvec4
		
		#define uint2 uvec2
		#define uint3 uvec3
		#define uint4 uvec4
		
		#define int2 ivec2
		#define int3 ivec3
		#define int4 ivec4

		#define float2x2 mat2x2 
		#define float3x3 mat3x3	
		#define float4x4 mat4x4	
		#define float2x3 mat2x3	
		#define float2x4 mat2x4	
		#define float3x2 mat3x2	
		#define float3x4 mat3x4	
		#define float4x2 mat4x2	
		#define float4x3 mat4x3	
		
		#define lerp mix
		#define frac fract
		#define saturate(x) clamp(x, 0, 1)	
		
		#define ddx(a) dFdx(a)
		#define ddy(a) dFdy(a)
		
		#define IF(a, x, y) mix(y, x, a)
		
		#define atan2(x, y) atan(y, x)
		
		#define modquick(a, b) a = mod((a),(b))				

		#define REGISTER_CST(n)	
		#define CONST_DECL(decl, idx) layout(location = idx) uniform decl;
		//#define CONST_DECL(decl, idx) uniform decl REGISTER_CST(idx)		
		
		#define ARRAY(a, size) a[size](
		#define ENDARRAY )
		
		#if defined(VERTEXSHADER)	
			#define TEXCOORD_DECL(decl, semantic) out decl
			
			#define INPUT_DECL(decl, semantic) layout(location = semantic) in decl
		#elif defined(PIXELSHADER)
			#define TEXCOORD_DECL(decl, semantic) in decl
			
			void clip(float v) { if(v < 0) discard; }			
			void clip(vec2 v)  { if(any(lessThan(v, vec2(0)))) discard; }			
			void clip(vec3 v)  { if(any(lessThan(v, vec3(0)))) discard; }		
			void clip(vec4 v)  { if(any(lessThan(v, vec4(0)))) discard; }
			
			#define OUTPUT_COL(decl, semantic) layout(location = semantic) out decl			
			#define OUTPUT_DEPTH(decl) layout(depth_any) out decl			
		#endif

		#define REGISTER_SMP(n)							
		#define LAYOUT_SMP(n)			
			
		#define samplerCUBE samplerCube						
		
		#define BEGIN_STRUCT(name)
		#define END_STRUCT
		
		#define BRANCH 
		#define UNROLL
		
		#define FLATTEN 
		#define FLOAT3force(a) vec3(a)	
		
		#define x_scattering_ext__opacity x_scattering_ext_opacity
		#define x_scattering_ins__zero x_scattering_ext_zero
		
		#define I_SIDE !gl_FrontFacing
		#define fmod(a, b) (sign(a) * abs(mod(a, b)))
		#define rsqrt(a) pow(a, -0.5)
				
		#if !defined(OPENGL_FLOAT_SWIZZLES)
			float SwizzleX(float x) 		{ return x; }
			float SwizzleX(float2 x) 		{ return x.x; }
			float SwizzleX(float3 x) 		{ return x.x; }
			float SwizzleX(float4 x) 		{ return x.x; }
			
			float2 SwizzleXX(float x) 		{ return float2(x); }
			float2 SwizzleXX(float2 x) 		{ return x.xx; }
			float2 SwizzleXX(float3 x) 		{ return x.xx; }
			float2 SwizzleXX(float4 x) 		{ return x.xx; }
			
			float3 SwizzleXXX(float x) 		{ return float3(x); }
			float3 SwizzleXXX(float2 x) 	{ return x.xxx; }
			float3 SwizzleXXX(float3 x) 	{ return x.xxx; }
			float3 SwizzleXXX(float4 x) 	{ return x.xxx; }
			
			float4 SwizzleXXXX(float x) 	{ return float4(x); }
			float4 SwizzleXXXX(float2 x) 	{ return x.xxxx; }
			float4 SwizzleXXXX(float3 x) 	{ return x.xxxx; }
			float4 SwizzleXXXX(float4 x) 	{ return x.xxxx; }
		#else
			#define SwizzleX(a) 	(a).x
			#define SwizzleXX(a) 	(a).xx
			#define SwizzleXXX(a) 	(a).xxx
			#define SwizzleXXXX(a) 	(a).xxxx
		#endif
	#else	
	
		#define swizzle_func_0(a) a.x
		#define swizzle_func_1(a) a.y
		#define swizzle_func_2(a) a.z
		#define swizzle_func_3(a) a.w
		
		#define lessThan(a, b) ((a) < (b))
		#define lessThanEqual(a, b) ((a) <= (b))
		#define greaterThan(a, b) ((a) > (b))
		#define greaterThanEqual(a, b) ((a) >= (b))	
		#define equal(a, b) ((a) == (b))			
		#define notEqual(a, b) ((a) != (b))	
		
		#define IF(a, x, y) ((a) ? (x) : (y))
		
		#define mod(a, b) ((a) % (b))	
		
		#define modquick(a, b) ((a) %= (b))			
		
		#define REGISTER_CST(n) : register(c##n)	

		#define ARRAY(a, size) {
		#define ENDARRAY }		
		
		#if defined(VERTEXSHADER)
		
			#define INPUT_DECL(decl, semantic) decl : semantic
		
		#elif defined(PIXELSHADER)						
			
			#define OUTPUT_COL(decl, semantic) decl : semantic		
			
			#define OUTPUT_DEPTH(decl) decl : DEPTH
			
		#endif

		#define REGISTER_SMP(n) : register(s##n)		
		#define LAYOUT_SMP(n)	
		
		#define BEGIN_STRUCT(name) struct name {
		#define END_STRUCT };	
		#define TEXCOORD_DECL(decl, semantic) decl : semantic	

        #define TEXCOORD_H2D_DECL(decl, semantic) decl : semantic	
        #define TEXCOORD_D2P_DECL(decl, semantic) decl : semantic	
        #define TEXCOORD_T2D_DECL(decl, semantic) decl : semantic
		
		#define STRING(a) STRINGIFY(a)
		#define STRINGIFY(a) #a
		
		#define CONST_DECL(decl, idx) uniform decl REGISTER_CST(idx)
		
		#define BRANCH [ branch ] 
		#define UNROLL [ unroll ]
		#define FLATTEN [ flatten ] 
		
		#define float4cstr(a) (a)
		#define FLOAT4cstr(a) (a)
		
		#define float3cstr(a) (a)
		#define FLOAT3cstr(a) (a)
		
		#define float2cstr(a) (a)
		#define FLOAT2cstr(a) (a)
		
		#define FLOAT3force(a) (a)	
		
		#define SwizzleX(a) 	(a).x
		#define SwizzleXX(a) 	(a).xx
		#define SwizzleXXX(a) 	(a).xxx
		#define SwizzleXXXX(a) 	(a).xxxx
	#endif

		
	#define SAMPLER_DECL(decl, idx) LAYOUT_SMP(idx) uniform decl REGISTER_SMP(idx)	
	#define SAMPLER_VS_DECL(decl, idx) uniform decl REGISTER_SMP(idx)
	#define SAMPLER_CS_DECL(decl, idx) uniform decl REGISTER_SMP(idx)
	#define SAMPLER_DS_DECL(decl, idx) uniform decl REGISTER_SMP(idx)
	#define SAMPLER_HS_DECL(decl, idx) uniform decl REGISTER_SMP(idx)	

	#include <EngineDefs.hlsl>
	
	// Orbis does not support fixed types (half)
	#if defined(SHADER_PATH_ORBIS)
		#define FORCE_FLOAT_ON
	#endif

    #if defined(FORCE_FLOAT_ON) || defined(VERTEXSHADER) || (HSM_MODE == HSMM_ATI) || (HSM_MODE == HSMM_XENON) || defined(SHADER_PATH_OPENGL)
        #define FLOAT float
        #define FLOAT2 float2
        #define FLOAT3 float3
        #define FLOAT4 float4
        #define FLOAT3x3 float3x3
        #define FLOAT4x4 float4x4
    #else
        #define HALF_ON 1
        #define FLOAT half
        #define FLOAT2 half2
        #define FLOAT3 half3
        #define FLOAT4 half4
        #define FLOAT3x3 half3x3
        #define FLOAT4x4 half4x4
    #endif

    #if defined(SHADER_PATH_PS3) && !defined(FORCE_FLOAT_ON) && !defined(VERTEXSHADER)
        #define CONST_FLOAT uniform half
        #define CONST_FLOAT2 uniform half2
        #define CONST_FLOAT3 uniform half3
        #define CONST_FLOAT4 uniform half4
        #define CONST_FLOAT3x3 uniform half3x3
        #define CONST_FLOAT4x4 uniform half4x4
    #else
        #define CONST_FLOAT uniform float
        #define CONST_FLOAT2 uniform float2
        #define CONST_FLOAT3 uniform float3
        #define CONST_FLOAT4 uniform float4
        #define CONST_FLOAT3x3 uniform float3x3
        #define CONST_FLOAT4x4 uniform float4x4
    #endif

	#if defined(SHADER_PATH_X360)
		#define ISOLATE [isolate]
	#else
		#define ISOLATE
	#endif

    //#define FXAA_ON 1

    #define NUM_SM 4

    #define SM_BIAS_VN_FACTOR 10

    #define FLOAT16_DEPTH_SCALE 100.0

    #define SM11 0
    #define SM14 1
    #define SM20 2
    #define SM30 3
    #define SM31 4
    #define SM40 5
    #define SM32 6    
    #define SM50 7    
    #define SM41 8

    //#define VERTEXBLENDING_CONSTNUM 216

//    #define XENON_HDR_SCALE 32.0
    #define XENON_HDR_BUFFER_FACTOR 8.0
    #define XENON_HDR_SCALE 32.0/XENON_HDR_BUFFER_FACTOR

    #define SHQ_HIGH 0
    #define SHQ_NORMAL 1
    #define SHQ_LOW 2
    #define SHQ_VERYLOW 3

    //keep it synchronized with DefaultValues.mtt
    #define SPC_MODEL 0
    #define SPC_WORLD 1
    #define SPC_INSTANCE 2
    #define SPC_CAMERA 3
    #define SPC_SHORE 4
    #define SPC_BUCKET 5
    #define SPC_FX_WORLD 6
    #define SPC_FX_CAMERA 7

    //keep it synchronized with DefaultValues.mtt
    #define TCH_OPQ 1
    #define TCH_TRN 2
    #define TCH_NRM 3
    #define TCH_RFL 4
    #define TCH_SHD 5
    #define TCH_DPT 6
	
	// use this helper for proper output color semantic usage
	#if defined(SHADER_PATH_DX11) || defined(SHADER_PATH_DX10)
		#define OUT_COLOR_SEMANTIC(idx) SV_TARGET##idx
	#else
		#define OUT_COLOR_SEMANTIC(idx) COLOR##idx
	#endif
	
	// system values mapping 4 Orbis
	#if defined(SHADER_PATH_ORBIS)
		#include "Defines_Orbis.hlsl"
	#endif
	
    #define DEFINES_INCLUDED 1
#endif
