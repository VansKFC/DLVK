#if (HSM_MODE == HSMM_DX11)
	SamplerComparisonState s_shadowmap;
	Texture2D<float> t_shadowmap;
#else 
	uniform Texture2D t_shadowmap;
	uniform sampler2D s_shadowmap;
#endif

CONST_FLOAT4 TEX_INV_SIZE_s_shadowmap;
CONST_FLOAT4 TEX_SIZE_s_shadowmap;
CONST_FLOAT4 Z_RANGE_SWAP_PARAMS;
FLOAT Sample_Shadowmap(FLOAT4 v_uv)	
{
	FLOAT f_shadowmap = 1.0;
	#if defined(SHADER_PATH_PS3)
		f_shadowmap = h1texcompare2D(s_shadowmap, v_uv.xyz);
	#elif defined(SHADER_PATH_OPENGL)
		v_uv.xyz = v_uv.xyz / v_uv.w;
		v_uv.w = 1.0;
		v_uv.y = 1.0 - v_uv.y;
		v_uv.z = v_uv.z * 0.5 + 0.5;
		f_shadowmap = SamplePROJ_f1(0, s_shadowmap, v_uv);
	#elif (HSM_MODE == HSMM_NVIDIA)
		f_shadowmap = Sample_h1(t_shadowmap, s_shadowmap, v_uv);
	#elif (HSM_MODE == HSMM_DX11)
		#if defined(SHADER_PATH_ORBIS)
			f_shadowmap = Z_RANGE_SWAP_PARAMS.x * t_shadowmap.SampleCmpLOD0(s_shadowmap, v_uv.xy, Z_RANGE_SWAP_PARAMS.x * v_uv.z + + Z_RANGE_SWAP_PARAMS.y) + Z_RANGE_SWAP_PARAMS.y; 
		#else
			f_shadowmap = Z_RANGE_SWAP_PARAMS.x * t_shadowmap.SampleCmpLevelZero(s_shadowmap, v_uv.xy, Z_RANGE_SWAP_PARAMS.x * v_uv.z + + Z_RANGE_SWAP_PARAMS.y) + Z_RANGE_SWAP_PARAMS.y; 
		#endif 
	#elif (HSM_MODE == HSMM_ATI) || (HSM_MODE == HSMM_XENON)
		f_shadowmap = Sample_f1(t_shadowmap, s_shadowmap, v_uv.xy, 0.0);
	#endif
	return f_shadowmap;
}

FLOAT4 Sample_Shadowmap_4(FLOAT4 v_uv)	
{
	FLOAT4 v_shadowmap = float4(1.0, 1.0, 1.0, 1.0);
	#if defined(SHADER_PATH_PS3) || (HSM_MODE == HSMM_NVIDIA) || (HSM_MODE == HSMM_DX11) || defined(SHADER_PATH_OPENGL)
		v_shadowmap = SwizzleXXXX(Sample_Shadowmap(v_uv));
	#elif (HSM_MODE == HSMM_ATI) && defined(FETCH4)
		v_shadowmap = Sample_h4(t_shadowmap, s_shadowmap, v_uv.xy + FLOAT2(-0.5,-0.5) * TEX_INV_SIZE_s_shadowmap.xy, 0.0);
	#elif  (HSM_MODE == HSMM_XENON)
	asm
	{
		tfetch2D v_shadowmap.x___, v_uv.xy, s_shadowmap, OffsetX = -0.5, OffsetY = -0.5, MagFilter=point, MinFilter=point, UseComputedLOD=false
		tfetch2D v_shadowmap._x__, v_uv.xy, s_shadowmap, OffsetX =  0.5, OffsetY = -0.5, MagFilter=point, MinFilter=point, UseComputedLOD=false
		tfetch2D v_shadowmap.__x_, v_uv.xy, s_shadowmap, OffsetX = -0.5, OffsetY =  0.5, MagFilter=point, MinFilter=point, UseComputedLOD=false
		tfetch2D v_shadowmap.___x, v_uv.xy, s_shadowmap, OffsetX =  0.5, OffsetY =  0.5, MagFilter=point, MinFilter=point, UseComputedLOD=false
	};
	#endif
	return v_shadowmap;
}

FLOAT Shadows_Calc(FLOAT4 v_uv_shadowmap)	
{
	FLOAT f_shadowmap = Sample_Shadowmap(v_uv_shadowmap);

	FLOAT f_shadow = 1.0;

	#if defined(SHADER_PATH_PS3) || (HSM_MODE == HSMM_NVIDIA) || (HSM_MODE == HSMM_DX11) || defined(SHADER_PATH_OPENGL)
		f_shadow = f_shadowmap;
	#elif (HSM_MODE == HSMM_ATI) || (HSM_MODE == HSMM_XENON)
		v_uv_shadowmap.z = saturate(v_uv_shadowmap.z);
		#if (HSM_MODE == HSMM_XENON)
			f_shadowmap = 1.0f - f_shadowmap;
		#endif
		f_shadow = step(v_uv_shadowmap.z, f_shadowmap);
	#endif

	return f_shadow;
}

FLOAT Shadows_Calc_PCF(FLOAT4 v_uv_shadowmap)	
{
	FLOAT f_shadow = 1.0;
	#if defined(SHADER_PATH_PS3) || (HSM_MODE == HSMM_NVIDIA) || (HSM_MODE == HSMM_DX11) || defined(SHADER_PATH_OPENGL)
		f_shadow = Shadows_Calc(v_uv_shadowmap);
	#elif (HSM_MODE == HSMM_ATI) || (HSM_MODE == HSMM_XENON)
		float4 v_shadowmap = Sample_Shadowmap_4(v_uv_shadowmap);
		v_uv_shadowmap.z = saturate(v_uv_shadowmap.z);
		float4 v_weights;
		#if (HSM_MODE == HSMM_XENON)
			v_shadowmap = 1.0 - v_shadowmap;
			asm
			{
				getWeights2D v_weights, v_uv_shadowmap.xy, s_shadowmap, MagFilter=linear, MinFilter=linear
			};
			v_weights.zw = 1.0 - v_weights.xy;
			v_weights = v_weights.zxzx * v_weights.wwyy;
		#else
			v_weights.zw = frac(v_uv_shadowmap.xy * TEX_SIZE_s_shadowmap.xy - 0.5);
			v_weights.xy = 1.0 - v_weights.zw;
			v_weights = v_weights.zxzx * v_weights.ywwy;
		#endif
		float4 v_shadow = step(v_uv_shadowmap.z, v_shadowmap);
		f_shadow = dot(v_shadow, v_weights);
	#endif
	return f_shadow;
}

FLOAT Shadows_Calc_PFC_X360(float2 v_uv_shadowmap, float4 v_shadows, float f_shadowmap_z)
{
	FLOAT f_shadow = 1.0;
	
	#if (HSM_MODE == HSMM_XENON)
		float4 v_shadowmap = v_shadows;
		f_shadowmap_z = saturate(f_shadowmap_z);
		float4 v_weights;
		
		v_shadowmap = 1.0 - v_shadowmap;
		asm
		{
			getWeights2D v_weights, v_uv_shadowmap.xy, s_shadowmap, MagFilter=linear, MinFilter=linear
		};
		v_weights.zw = 1.0 - v_weights.xy;
		v_weights = v_weights.zxzx * v_weights.wwyy;
		
		float4 v_shadow = step(f_shadowmap_z, v_shadowmap);
		f_shadow = dot(v_shadow, v_weights);
	#endif
	return f_shadow;    
}

FLOAT Shadows_Blur(FLOAT4 v_uv_shadowmap, FLOAT f_kernel)
{
	FLOAT4 v_uv = v_uv_shadowmap;
	
	FLOAT f_shadow = 0.0;

	#if defined(SHADER_PATH_X360)    
		FLOAT2 filterX[] = 
		{
		  { -1.0, -1.0 },
		  {  0.0, -1.0 },
		  {  1.0, -1.0 },
		  
		  { -1.0,  0.0 },
		  {  0.0,  0.0 },
		  {  1.0,  0.0 },
		  
		  { -1.0,  1.0 },
		  {  0.0,  1.0 },
		  {  1.0,  1.0 },                  
		};
		  FLOAT2 v_offset_scale =  1.0 * V_SHADOWMAP_INV_SIZE;
		  
		  FLOAT f_shadow_0 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[0].xy, 0.0 );
		  FLOAT f_shadow_1 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[1].xy, 0.0 );
		  FLOAT f_shadow_2 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[2].xy, 0.0 );
		  FLOAT f_shadow_3 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[3].xy, 0.0 );
		  FLOAT f_shadow_4 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[4].xy, 0.0 );
		  FLOAT f_shadow_5 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[5].xy, 0.0 );
		  FLOAT f_shadow_6 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[6].xy, 0.0 );
		  FLOAT f_shadow_7 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[7].xy, 0.0 );
		  FLOAT f_shadow_8 = Sample_f1( t_shadowmap, s_shadowmap, v_uv.xy + v_offset_scale * filterX[8].xy, 0.0 );
  
		  FLOAT4 v_shadows_0 = FLOAT4(f_shadow_0, f_shadow_1, f_shadow_3, f_shadow_4);
		  FLOAT4 v_shadows_1 = FLOAT4(f_shadow_1, f_shadow_2, f_shadow_4, f_shadow_5);
		  FLOAT4 v_shadows_2 = FLOAT4(f_shadow_3, f_shadow_4, f_shadow_6, f_shadow_7);
		  FLOAT4 v_shadows_3 = FLOAT4(f_shadow_4, f_shadow_5, f_shadow_7, f_shadow_8);
		  
		  float4 v_uv_shadowmap_0 = v_uv_shadowmap.xyxy + float4( -0.5, -0.5, 0.5, -0.5) * V_SHADOWMAP_INV_SIZE.xyxy;
		  float4 v_uv_shadowmap_1 = v_uv_shadowmap.xyxy + float4( -0.5,  0.5,  0.5, 0.5) * V_SHADOWMAP_INV_SIZE.xyxy;
  
		  f_shadow += Shadows_Calc_PFC_X360(v_uv_shadowmap_0.xy, v_shadows_0, v_uv_shadowmap.z );
		  f_shadow += Shadows_Calc_PFC_X360(v_uv_shadowmap_0.zw, v_shadows_1, v_uv_shadowmap.z );
		  f_shadow += Shadows_Calc_PFC_X360(v_uv_shadowmap_1.xy, v_shadows_2, v_uv_shadowmap.z );
		  f_shadow += Shadows_Calc_PFC_X360(v_uv_shadowmap_1.zw, v_shadows_3, v_uv_shadowmap.z );
				  
		  f_shadow *= 0.25;
	 #else        
		 #if defined(SHADER_PATH_DX1x)
			FLOAT2 filter_array[] =
			{                
				{-1.5, -1.5},
				{-1.5, -0.5},              
				{-1.5,  0.5},
				{-1.5,  1.5},
				
				{-0.5, -1.5},
				{-0.5, -0.5},              
				{-0.5,  0.5},
				{-0.5,  1.5},
				
				{0.5, -1.5},
				{0.5, -0.5},              
				{0.5,  0.5},
				{0.5,  1.5},
				  
				{1.5, -1.5},
				{1.5, -0.5},              
				{1.5,  0.5},
				{1.5,  1.5},
			};
			#define I_NUM_SAMPLES 16
			#define F_INV_NUM_SAMPLES 0.0625
		#else     
			FLOAT2 filter_array[] = 
			ARRAY(FLOAT2, 4)			
				FLOAT2( 0.5,  0.5 ),
				FLOAT2(-0.5,  0.5 ),
				FLOAT2( 0.5, -0.5 ),
				FLOAT2(-0.5, -0.5 )  
			ENDARRAY; 
			#define I_NUM_SAMPLES 4
			#define F_INV_NUM_SAMPLES 0.25
		#endif  
		  
		FLOAT2 v_offset_scale = V_SHADOWMAP_INV_SIZE;
		
		for(int i = 0; i < I_NUM_SAMPLES; i++)
		{

			FLOAT2 v_uv_shadow_offset = filter_array[i].xy * f_kernel;
	   
			f_shadow += Shadows_Calc_PCF(v_uv + FLOAT4(v_offset_scale * v_uv_shadow_offset.xy,0.0,0.0));
		}

		f_shadow *= F_INV_NUM_SAMPLES;
	#endif

	return smoothstep(0.0, 1.0, f_shadow); 
}
#if defined(SHADER_PATH_DX1x)
   #define F_SHD_MASK_THRESHOLD 0.97
#else
   #define F_SHD_MASK_THRESHOLD 0.98
#endif
FLOAT Shadows_Sun_New(float4 v_pos , FLOAT3 v_nrm)
{
	FLOAT3 v_nrm_ls = Mul33(v_nrm, HSM_XFORM_ES_0);
	FLOAT3 v_nrm_n_ls = normalize(v_nrm_ls);
	FLOAT2 v_offset_vec = V_SHADOWMAP_INV_SIZE * FLOAT2(4.0, 1.0);
	#if defined(SHADER_PATH_X360) || defined(SHADER_PATH_PS3)
		v_offset_vec *= 2.0;
	#else
		v_offset_vec *= 3.0;
	#endif
	FLOAT f_offset = length(v_offset_vec);
	FLOAT3 v_pos_sm_offset = f_offset * v_nrm_n_ls * FLOAT3(0.125, 0.5, 1.0);

	// FLOAT2 v_nrm_ls = Mul33(v_nrm, HSM_XFORM_ES_0).xy;
	// FLOAT2 v_nrm_n_ls = normalize(v_nrm_ls);
	// FLOAT f_offset = length(V_SHADOWMAP_INV_SIZE);
	// FLOAT3 v_pos_sm_offset = -(sqrt(2.0) * 0.5) / 65535.0;
	// v_pos_sm_offset.xy = f_offset * v_nrm_n_ls * FLOAT2(0.25, 1.0);
	// #if !defined(SHADER_PATH_X360) && !defined(SHADER_PATH_PS3)
		// v_pos_sm_offset.xy *= 2.5;
	// #endif
	
	FLOAT4 v_uvs_shadowmap_x;
	v_uvs_shadowmap_x.x = dot(v_pos, HSM_XFORM_ES_0[0]);
	v_uvs_shadowmap_x.y = dot(v_pos, HSM_XFORM_ES_1[0]);
	v_uvs_shadowmap_x.z = dot(v_pos, HSM_XFORM_ES_2[0]);
	v_uvs_shadowmap_x.w = dot(v_pos, HSM_XFORM_ES_3[0]);		

	FLOAT4 v_uvs_shadowmap_y;
	v_uvs_shadowmap_y.x = dot(v_pos, HSM_XFORM_ES_0[1]);
	v_uvs_shadowmap_y.y = dot(v_pos, HSM_XFORM_ES_1[1]);
	v_uvs_shadowmap_y.z = dot(v_pos, HSM_XFORM_ES_2[1]);
	v_uvs_shadowmap_y.w = dot(v_pos, HSM_XFORM_ES_3[1]);		

	FLOAT4 v_masks = max(abs(v_uvs_shadowmap_x), abs(v_uvs_shadowmap_y));		
	FLOAT4 v_weights = IF(greaterThan(v_masks, SwizzleXXXX(F_SHD_MASK_THRESHOLD)), SwizzleXXXX(0.0), SwizzleXXXX(1.0));
	v_weights.w = saturate(dot(v_weights, FLOAT4(-1.0, -1.0, -1.0, 1.0))) ;
	v_weights.z = saturate(dot(v_weights.xyz, FLOAT3(-1.0, -1.0, 1.0)));
	v_weights.y = saturate(v_weights.y - v_weights.x);

	FLOAT4 v_uvs_shadowmap_x_remapped = v_uvs_shadowmap_x * 0.125 + FLOAT4(0.125, 0.375, 0.625, 0.875);
	FLOAT4 v_uvs_shadowmap_y_remapped = v_uvs_shadowmap_y * 0.5 + 0.5;

	FLOAT4 v_uv_shadowmap_sample = float4(1.0, 1.0, 1.0, 1.0); //nVidia: lod, ati/xenon: n/a
	
	v_uv_shadowmap_sample.x = dot(v_weights, v_uvs_shadowmap_x_remapped);	
	v_uv_shadowmap_sample.y = dot(v_weights, v_uvs_shadowmap_y_remapped);
	v_uv_shadowmap_sample.xy += v_pos_sm_offset.xy;

	float4 v_shadow_xfm_n_2 = float4(0.0, 0.0, 0.0, 0.0);
	v_shadow_xfm_n_2 += v_weights.x * HSM_XFORM_ES_0[2];
	v_shadow_xfm_n_2 += v_weights.y * HSM_XFORM_ES_1[2];
	v_shadow_xfm_n_2 += v_weights.z * HSM_XFORM_ES_2[2];
	v_shadow_xfm_n_2 += v_weights.w * HSM_XFORM_ES_3[2];		
	v_uv_shadowmap_sample.z = dot(v_pos, v_shadow_xfm_n_2);
	v_uv_shadowmap_sample.z += v_pos_sm_offset.z ;
	
	#if defined(SHADER_PATH_X360) || defined(SHADER_PATH_PS3)
		FLOAT f_shadow = Shadows_Calc_PCF(v_uv_shadowmap_sample);
	#else	
		FLOAT f_kernel = saturate(dot(v_weights, FLOAT4(1.0, 0.5, 0.25, 0.125)));
		FLOAT f_shadow = Shadows_Blur(v_uv_shadowmap_sample, f_kernel);
	#endif	

	FLOAT f_mask = saturate(dot(v_weights, float4(1.0, 1.0, 1.0, 1.0)));
	if(f_mask <= 0.0) f_shadow = 1.0;

	#if !defined(SHADER_PATH_X360) && !defined(SHADER_PATH_PS3)
		FLOAT fade_mask = saturate(v_uvs_shadowmap_x.w * v_uvs_shadowmap_x.w + v_uvs_shadowmap_y.w * v_uvs_shadowmap_y.w); 

		FLOAT3 cam_pos_hsm = FLOAT3(HSM_XFORM_ES_3[0].w, HSM_XFORM_ES_3[1].w, HSM_XFORM_ES_3[2].w);
		FLOAT3 pos_hsm = float3(v_uvs_shadowmap_x.w, v_uvs_shadowmap_y.w, dot(v_pos, HSM_XFORM_ES_3[2]));

		FLOAT opq_shadow_distance = length(cam_pos_hsm);
		FLOAT pixel_distance = distance(pos_hsm, cam_pos_hsm);

		fade_mask *= saturate((pixel_distance / opq_shadow_distance - 1.0) * 2.0);
		f_shadow = saturate(f_shadow + fade_mask);
	#endif

	return f_shadow;
}
