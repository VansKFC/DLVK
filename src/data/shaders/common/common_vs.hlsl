#if !defined(COMMON_VS_INCLUDED)

    float4 Decode_Pos(float4 v_pos)
    {
        v_pos.xyz = v_pos.xyz * POSITION_BIAS_SCALE.w;
        return v_pos;
    }
    float2 Decode_UV(float2 v_uv)
    {
        return v_uv * NRM_TAN_TEX_SCALE.z;
    }

	float4 Decode_Usr(in float4 usr_clr, out float4 usr_1)
    {
		float4 usr_0 = frac(usr_clr);
		usr_1 = (usr_clr - usr_0) / 255.0;
		return usr_0 * (256.0/255.0);
    }

	float4 Decode_Usr(in float4 usr_clr)
    {
		float4 usr_0;
		float4 usr_1;
		
		usr_0 = Decode_Usr(usr_clr, usr_1);
		return usr_0;
    }    

	float4 Pos_Out(float4 v_pos)
    {
        return Mul44(v_pos, COMBINED_XFORM);
    }

    float4 Pos_Out_WS(float4 v_pos)
    {
        return Mul44(v_pos, VIEWPROJ_XFORM);
    }

    float4 Pos_Out_CS(float4 v_pos)
    {
        return Mul44(v_pos, PROJECTION_XFORM);
    }

    float2 UV_TexMod(float2 v_uv, float4 v_mtx[4])
    {
        return Mul42(float4(v_uv, 0.0, 1.0), v_mtx);
    }
	
	#define COMMON_VS_INCLUDED 1    	 
#endif
