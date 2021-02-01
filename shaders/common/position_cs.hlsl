#if !defined(POSITION_CS_INCLUDED)

	// POSITION CS ///////////////////////////////////
    float2 Frust_Out_PP(float4 v_pos_in) { return v_pos_in.xy * INV_FRUSTUM_1.xy + INV_FRUSTUM_1.zw; }

    float3 Cam_Dir_Out_PP(float4 v_pos_in)
    {
        float3 v_cam_dir = -float3(1.0, 1.0, 1.0);
        v_cam_dir.xy = Frust_Out_PP(v_pos_in);
        return v_cam_dir;
    }
    float3 Cam_Dir_Out_Mesh(float4 v_pos_in)
    {
        v_pos_in.xy = (v_pos_in.xy * float2(0.5, -0.5) + float2(0.5, 0.5)) * RENDER_TARGET_PARAMS.zw;
        float3 v_cam_dir = -float3(1.0, 1.0, 1.0);
        v_cam_dir.xy = Frust_Out_PP(v_pos_in);
        return v_cam_dir;
    }

    float4 Pos_CS(float f_depth, float4 v_pos_ss)
    {
		float4 v_pos_cs = float4(1.0, 1.0, 1.0, 1.0);
		v_pos_cs.xy = Frust_Out_PP(v_pos_ss);
		v_pos_cs.xy *= f_depth;
		v_pos_cs.z = -f_depth;
	
		#if defined(PIXELSHADER) && defined(STEREO_TMU_ON)
            v_pos_cs.x += stereoXOffsetNPOS(f_depth);
        #endif
	
        return v_pos_cs;
    }
	
	
	
    float4 Pos_CS(float f_depth, float3 v_cam_dir)
    {
        float4 v_pos_cs = float4(1.0, 1.0, 1.0, 1.0);
        v_pos_cs.xyz = v_cam_dir * f_depth;

		#if defined(PIXELSHADER) && defined(STEREO_TMU_ON)
            v_pos_cs.x += stereoXOffsetNPOS(f_depth);
        #endif
	
        return v_pos_cs;
    }

	#define POSITION_CS_INCLUDED 1    	 
#endif
