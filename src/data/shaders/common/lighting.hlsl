#if !defined(LIGHTING_INCLUDED)

	float IF_SSS(float matid_bx2, float true_val, float false_val)
	{
		return (matid_bx2 < 0.0) ? true_val : false_val;
	}
	float3 IF_SSS(float matid_bx2, float3 true_val, float3 false_val)
	{
		return (matid_bx2 < 0.0) ? true_val : false_val;
	}

	float IF_METAL(float matid_bx2, float true_val, float false_val)
	{
		return (matid_bx2 >= 1.0) ? true_val : false_val;
	}
	float3 IF_METAL(float matid_bx2, float3 true_val, float3 false_val)
	{
		return (matid_bx2 >= 1.0) ? true_val : false_val;
	}

	float IF_LEAVES(float matid_bx2, float true_val, float false_val)
	{
		return (matid_bx2 <= -1.0) ? true_val : false_val;
	}
	float3 IF_LEAVES(float matid_bx2, float3 true_val, float3 false_val)
	{
		return (matid_bx2 <= -1.0) ? true_val : false_val;
	}
	float IF_SKIN(float matid_bx2, float true_val, float false_val)
	{
		float skin_val = (matid_bx2 > 0.0) ? true_val : false_val;
		return (matid_bx2 < 1.0) ? skin_val : false_val;
	}
	float3 IF_SKIN(float matid_bx2, float3 true_val, float3 false_val)
	{
		float3 skin_val = (matid_bx2 > 0.0) ? true_val : false_val;
		return (matid_bx2 < 1.0) ? skin_val : false_val;
	}
	float IF_SSS_OFF(float matid_bx2, float true_val, float false_val)
	{
		return (matid_bx2 >= 1.0) ? true_val : false_val;
	}
	float3 IF_SSS_OFF(float matid_bx2, float3 true_val, float3 false_val)
	{
		return (matid_bx2 >= 1.0) ? true_val : false_val;
	}
	#define DIELECTRIC_SPECULAR_MAX 0.36
	FLOAT GBufferDecode(in FLOAT4 clr, in FLOAT matid_bx2, out FLOAT3 albedo_diffuse, out FLOAT3 albedo_specular)
	{
		FLOAT albedo_specular_dielectric = abs(matid_bx2) * DIELECTRIC_SPECULAR_MAX;
		albedo_diffuse = IF_METAL(matid_bx2, SwizzleXXX(0.0), clr.xyz);
		albedo_specular = IF_METAL(matid_bx2, clr.xyz, SwizzleXXX(albedo_specular_dielectric));
		return clr.w * clr.w;
	}

	FLOAT ShadingDielectric(FLOAT matid_bx2, FLOAT shading, FLOAT rgh)
	{
		FLOAT shading_leaves = saturate(shading * 0.5 + 0.5);
		shading_leaves *= shading_leaves;
		FLOAT shading_lambert = abs(shading);
		FLOAT shading_oren = sqrt(shading_lambert);
		FLOAT shading_dielectric = lerp(shading_lambert, shading_oren, rgh);
		shading_dielectric = IF_LEAVES(matid_bx2, shading_leaves, shading_dielectric);
		return shading_dielectric;
	}
	
	#define ONE_ON_LN2_X6 8.656170
	FLOAT3 Fresnel(FLOAT3 albedo, FLOAT angle, FLOAT matid_bx2, FLOAT rgh)
	{
		float rgh_nrm_inv = 1.0 / (31.0 * rgh + 1.0);

		FLOAT dot_inv5 = exp2(-ONE_ON_LN2_X6 * angle); //spherical gaussian approximation
		dot_inv5 *= rgh_nrm_inv; //normlization by roughness
		FLOAT3 fresnel = saturate(albedo + (1.0 - albedo) * dot_inv5);
		fresnel = IF_LEAVES(matid_bx2, SwizzleXXX(0.0), fresnel);
		return fresnel;
	}

	#define PI 3.1415926535897932384626433832795
	#define MIN_TROWBRIDGE_ROUGHNESS 0.0025
	#define MAX_TROWBRIDGE_ROUGHNESS (1.0 - MIN_TROWBRIDGE_ROUGHNESS)
	#define DOT_EPSILON 0.01
	#define A_FACTOR sqrt(2.0 / PI)

	#define NdotH dots_sat.x
	#define LdotH dots_sat.y
	#define NdotsVL dots_sat.zw

	FLOAT3 Specular(in FLOAT3 lit_dir_n, in FLOAT3 cam_dir_n, in FLOAT3 nrm_dir_n, in FLOAT3 albedo, in FLOAT matid, in FLOAT rgh, in FLOAT NdotL, in FLOAT NdotV, out FLOAT3 fresnel)
	{
		FLOAT3 half_dir_n = normalize(lit_dir_n + cam_dir_n);

		FLOAT4 dots;
		dots.x = dot(nrm_dir_n, half_dir_n); //NdotH
		dots.y = dot(lit_dir_n, half_dir_n); //LdotH
		dots.z = NdotV;
		dots.w = NdotL;

		FLOAT4 dots_sat = max(dots, FLOAT4(DOT_EPSILON, DOT_EPSILON, DOT_EPSILON, DOT_EPSILON));

		// fresnel = Fresnel(albedo, LdotH, matid, rgh); //???
		fresnel = Fresnel(albedo, LdotH, matid, 0.0);

		//distribution: Trowbridge-Reitz
		FLOAT m = rgh * MAX_TROWBRIDGE_ROUGHNESS + MIN_TROWBRIDGE_ROUGHNESS; //MAX_TROWBRIDGE_ROUGHNESS = 2.0, _x2
		FLOAT m2 = m * m;

		FLOAT dtr = NdotH * NdotH * (m2 - 1.0) + 1.0;
		dtr *= dtr;
		dtr *= 4.0;
		#if defined(AREA_LIGHT_ON)
			dtr *= PI; //not necessary with point and directional lights
		#endif

		//geometry: Schlick's approximation to Smith's Shadowing Function
		FLOAT2 as = FLOAT2(0.0, 1.0) + FLOAT2(A_FACTOR, -A_FACTOR) * SwizzleXX(m); //as.y = 1.0 - as.x
		FLOAT2 dots2 = NdotsVL * as.yy + as.xx;
		FLOAT V_inv = dots2.x * dots2.y;

		dtr	*= V_inv;

		FLOAT DxV = m2 / dtr;

		return DxV * fresnel;
	}

    FLOAT3 normalize_ds(FLOAT3 v_nrm)
    {
       	v_nrm.xyz = FLOAT3(normalize(v_nrm.xyz));
//        v_nrm.z = -sqrt(1.0 - v_nrm.x * v_nrm.x - v_nrm.y * v_nrm.y); //generates artifacts
        return v_nrm;
    }

    #if !defined(VERTEXSHADER) && defined(DECODE_TEX_ON)
		uniform Texture1D t_decode;
        uniform sampler1D s_decode;
        FLOAT4 Decode_Tex(FLOAT f_value) { return tex1Dlod(s_decode, FLOAT4(f_value, 0.0, 0.0, 0.0)); }
    #endif

    #if defined(MATERIAL_ID_ON)
        CONST_FLOAT4 V_MATERIAL_ID_PARAMS;

        #if !defined(VERTEXSHADER)
			#if defined(SHADER_PATH_PS3)
				#pragma texformat s_spc_tex ARGB8
				#pragma texformat s_spc_tex_fresnel ARGB8
				#pragma texformat s_diff_tex ARGB8
				#pragma texformat s_env_tex ARGB8
			#endif
			#if defined(MID_SPECULAR_ON)
				uniform Texture2D t_spc_tex;
				uniform sampler2D s_spc_tex;
				uniform Texture2D t_spc_tex_fresnel;
				uniform sampler2D s_spc_tex_fresnel;
			#endif
			#if defined(MID_DIFFUSE_ON)
				uniform Texture2D t_diff_tex;
				uniform sampler2D s_diff_tex;
			#endif
			#if defined(MID_ENV_ON)
				uniform Texture2D t_env_tex;
				uniform sampler2D s_env_tex;
			#endif
        #endif

        FLOAT GetMaterialV_int(FLOAT f_mat_int, FLOAT f_shn)
        {
			FLOAT2 v_mat_ext = f_mat_int * F_MATERIAL_ID_SCALE + V_MATERIAL_ID_OFFSET;
			return lerp(v_mat_ext.x, v_mat_ext.y, f_shn);
        }
		FLOAT GetMaterialV(FLOAT f_mat_id, FLOAT f_shn) //f_mat_id <0.0, 1.0>
        {
            FLOAT f_mat_int = floor(f_mat_id * FLOAT(256.0) + FLOAT(0.5));
			return GetMaterialV_int(f_mat_int, f_shn);
        }
		FLOAT GetMaterialV_bx2(FLOAT f_mat_id, FLOAT f_shn) //f_mat_id <-1.0, 1.0>
        {
			FLOAT f_mat_int = floor(f_mat_id * 128.0 + 128.5);
			return GetMaterialV_int(f_mat_int, f_shn);
        }
    #endif

	#define DIELECTRIC_PARAMS_TEX_SIZE_X 64.0
	#define DIELECTRIC_PARAMS_TEX_SIZE_Y 16.0

	#define DIELECTRIC_PARAMS_UV_SCALE_X (((DIELECTRIC_PARAMS_TEX_SIZE_X - 1.0) / DIELECTRIC_PARAMS_TEX_SIZE_X) * 0.5)
	#define DIELECTRIC_PARAMS_UV_SCALE_Y ((DIELECTRIC_PARAMS_TEX_SIZE_Y - 1.0) / DIELECTRIC_PARAMS_TEX_SIZE_Y)
	#define DIELECTRIC_PARAMS_UV_BIAS_X ((0.5 / DIELECTRIC_PARAMS_TEX_SIZE_X) + DIELECTRIC_PARAMS_UV_SCALE_X)
	#define DIELECTRIC_PARAMS_UV_BIAS_Y (0.5 / DIELECTRIC_PARAMS_TEX_SIZE_Y)

	#define DIELECTRIC_PARAMS_UV_SCALE FLOAT2(DIELECTRIC_PARAMS_UV_SCALE_X, DIELECTRIC_PARAMS_UV_SCALE_Y)
	#define DIELECTRIC_PARAMS_UV_BIAS FLOAT2(DIELECTRIC_PARAMS_UV_BIAS_X, DIELECTRIC_PARAMS_UV_BIAS_Y)

	//keep it synchronized with mtt_const_game.data and dielectric_params.dds
	#define DIELECTRIC_PARAMS_METALLIC_THRESHOLD (1.0 / 128.0)
	#define DIELECTRIC_PARAMS_SKIN_MIN_ID ((255.0 / 255.0) * 2.0 - 1.0)

	FLOAT3 Dielectric_Params_UV(FLOAT u, FLOAT v) //uv should be normalized X: <-1.0, 1.0> Y: <0.0, 1.0> (abs)
	{
		float v_min = (240.0 / 255.0) * 2.0 - 1.0;
		float v_max = 1.0;

		float v_mul = 1.0 / (v_max - v_min);
		float v_add = -v_min * v_mul;

		FLOAT3 uv_t = FLOAT3(u, v, v);
		uv_t.yz = uv_t.yz * SwizzleXX(v_mul) + SwizzleXX(v_add);
		uv_t.xy = uv_t.xy * DIELECTRIC_PARAMS_UV_SCALE + DIELECTRIC_PARAMS_UV_BIAS;


		return uv_t;
	}
	#define DIFFUSE_ALBEDO_MAX FLOAT3(243.0, 243.0, 242.0)
	#define DIFFUSE_ALBEDO_MIN FLOAT3(52.0, 52.0, 52.0)
	#define METALLIC_ALBEDO_MIN FLOAT3(128.0, 128.0, 128.0)
	#define DIFFUSE_ALBEDO_MAX_N (DIFFUSE_ALBEDO_MAX / 255.0)
	#define DIFFUSE_ALBEDO_MIN_N (DIFFUSE_ALBEDO_MIN / 255.0)
	#define METALLIC_ALBEDO_MIN_N (METALLIC_ALBEDO_MIN / 255.0)
	#define DIFFUSE_ALBEDO_ENCODE_SCALE (1.0 / (DIFFUSE_ALBEDO_MAX_N - DIFFUSE_ALBEDO_MIN_N))
	#define DIFFUSE_ALBEDO_ENCODE_BIAS (-DIFFUSE_ALBEDO_MIN_N * DIFFUSE_ALBEDO_ENCODE_SCALE)

	#define DIFFUSE_ALBEDO_DECODE_SCALE (DIFFUSE_ALBEDO_MAX_N - DIFFUSE_ALBEDO_MIN_N)
	#define DIFFUSE_ALBEDO_DECODE_BIAS DIFFUSE_ALBEDO_MIN_N

	 #define LIGHTING_INCLUDED 1
#endif
