#if !defined(FOG_INCLUDED)

//FOG
	CONST_FLOAT3 v_pp_fog_clr_glow;
	CONST_FLOAT4 v_pp_fog_scalebias;
	CONST_FLOAT3 v_pp_fog_bright;

	FLOAT FogBlack(FLOAT f_distance) // fog mask [black](for add)
	{
		FLOAT f_mask = FLOAT(saturate(f_distance * v_pp_fog_scalebias.z + v_pp_fog_scalebias.w)); //both masks: X: lerp (normal), Y: add (inverted)	
		f_mask *= f_mask;
		f_mask *= f_mask;
		f_mask = FLOAT(saturate(f_mask * v_pp_fog_scalebias.x + v_pp_fog_scalebias.y));
		return f_mask;
	}
		FLOAT FogBlack(FLOAT f_distance, FLOAT3 v_out)
		{
			FLOAT fog = FogBlack(f_distance);
			FLOAT lum = dot(v_out, v_pp_fog_bright);
			return saturate(lum + fog);
		}
	
	FLOAT4 Fog(FLOAT f_distance) //retunrns inverted fog mask (A) and modyfied fog color information (RGB)
	{
		FLOAT fb = FogBlack(f_distance);
		FLOAT4 v_out = FLOAT4(fb, fb, fb, fb);
		v_out.xyz = FLOAT3(v_pp_fog_clr_glow - v_out.xyz * v_pp_fog_clr_glow);
		return v_out;
	}	

		FLOAT4 Fog(FLOAT f_distance, FLOAT3 v_out)
		{
			FLOAT lum = dot(v_out, v_pp_fog_bright);
			FLOAT4 fog = Fog(f_distance);
			fog.w = saturate(lum + fog.w);
			return fog;
		}	

	FLOAT3 FogApply(FLOAT f_distance, FLOAT3 v_out)
	{
		FLOAT f_mask = FogBlack(f_distance);
		FLOAT3 fog = -v_pp_fog_clr_glow * FLOAT3(f_mask, f_mask, f_mask) + v_pp_fog_clr_glow;
		FLOAT lum = dot(v_out, v_pp_fog_bright);
		FLOAT mask = saturate(lum + f_mask);
		return v_out * mask + fog;
		// return FLOAT3(lerp(v_pp_fog_clr_glow, v_out, f_mask));
	}
// SCATTERING
	CONST_FLOAT3 v_pp_scattering_ray;
	CONST_FLOAT3 v_pp_scattering_mie;
	CONST_FLOAT3 v_pp_scattering_betas;
    CONST_FLOAT f_pp_scattering_sun_brightness;
    CONST_FLOAT f_pp_scattering_mie_g;
    CONST_FLOAT f_pp_scattering_sunset_factor;
    CONST_FLOAT f_pp_scattering_z_factor;
	CONST_FLOAT f_scattering_on;

	CONST_FLOAT3 v_pp_scattering_dist_factor;
	CONST_FLOAT f_pp_scattering_mie_g2;
	CONST_FLOAT3 v_pp_scattering_ray_scaled;
	CONST_FLOAT3 v_pp_scattering_mie_scaled;
	CONST_FLOAT f_pp_scattering_fm_scale;
	CONST_FLOAT f_pp_scattering_dn_scale;
	CONST_FLOAT f_pp_scattering_dn_bias;
	
	float3 Scattering_Ext(float dist)
	{
		return exp2(dist * v_pp_scattering_dist_factor);
	}

	#define FR_SCALE (3.0 / (4.0 * 3.14159265359))	
	float3 Scattering_Ins(float cos_th)
	{
        float fr = cos_th * cos_th * FR_SCALE + FR_SCALE;				
		float dn = sqrt(f_pp_scattering_dn_scale * cos_th + f_pp_scattering_dn_bias);
		float3 ins = v_pp_scattering_ray_scaled * fr + v_pp_scattering_mie_scaled / (dn * dn * dn);
        return ins;
	}

	float3 Scattering_Ins(float3 cam_dir_n, float3 lit_dir_n)
	{
		float cos_th = saturate(dot(-cam_dir_n, lit_dir_n));
		return Scattering_Ins(cos_th);
	}

	float3 Scattering_Ins(float3 ext, float3 cam_dir_n, float3 lit_dir_n)
	{
		float3 ins = Scattering_Ins(cam_dir_n, lit_dir_n);
		return ins - ins * ext;
	}

	float3 Scattering_Ins(float3 ext, float cos_th)
	{
		float3 ins = Scattering_Ins(cos_th);
		return ins - ins * ext;
	}
	
	float3 Scattering(float3 cam_dir_n, float3 lit_dir_n, float dist)
	{
		float3 ext = Scattering_Ext(dist);
		return Scattering_Ins(ext, cam_dir_n, lit_dir_n);
	}	
	
    float3 ScatteringApply(float3 cam_dir_n, float3 lit_dir_n, float dist, float3 v_out)
    {
        float3 ext = Scattering_Ext(dist);

        float3 ins = Scattering_Ins(ext, cam_dir_n, lit_dir_n);

        ext = saturate(v_out * v_pp_fog_bright + ext);

        return v_out.xyz * ext + ins;
    }
	 #define FOG_INCLUDED 1     
#endif
