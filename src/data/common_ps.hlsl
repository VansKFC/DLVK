#if !defined(COMMON_PS_INCLUDED)

	FLOAT2 UV_Screen(FLOAT4 v_uv_screen)
    {        
		#if defined(SHADER_PATH_PS3)
			return v_uv_screen.xy * RENDER_TARGET_PARAMS_BIAS.xy;
		#elif defined(SHADER_PATH_X360)
			return FLOAT2(v_uv_screen.xy * RENDER_TARGET_PARAMS_BIAS.xy + RENDER_TARGET_PARAMS_BIAS.xy * 0.5 );
		#else
			return FLOAT2(v_uv_screen.xy * RENDER_TARGET_PARAMS_BIAS.xy + RENDER_TARGET_PARAMS_BIAS.zw);
		#endif        
    }    

    float2 UV_Screen_From_Pos(float4 v_pos_out)
    {
    	float2 v_uv_screen = (v_pos_out.xy / v_pos_out.w);        
		v_uv_screen *= float2(0.5, -0.5);        
        return v_uv_screen + 0.5;
    }
	
	#define F_MAX_Z 1500000.0	
	
	 float4 Encode_Float8x4(float f_f32)
    {
        float f_f32_n = saturate(f_f32 / F_MAX_Z);
        f_f32_n *= 255.0/256.0;
        float4 v_f8x4 = frac(f_f32_n * V_FLOAT8x4_BITSHIFTS);
        v_f8x4 -= v_f8x4.xxyz * float4(   0,      1.0/256.0,    1.0/256.0,    1.0/256.0);
        return v_f8x4;
    }    
    

    float Decode_Float8x4(float4 v_f8x4)
    {
		v_f8x4 *= 256.0 / 255.0;
		float f_f32_n = dot(v_f8x4, 1.0 / V_FLOAT8x4_BITSHIFTS);
        float f_f32 = f_f32_n * F_MAX_Z;
        return f_f32;
    }
	
	FLOAT4 PackFloat16( FLOAT2 v_nrm )
    {   
        v_nrm *= 256.0;
		FLOAT2 x = FLOAT2(floor(v_nrm));
		v_nrm = (v_nrm - x) * 256.0;
		
		FLOAT2 y = FLOAT2(floor( v_nrm ));
		x *= 0.00390625;
		y *= 0.00390625;
		
		return FLOAT4( x.x, y.x, x.y, y.y ) - 0.5 / 256.0;	 
    }
        
    
    FLOAT2 UnpackFloat16(FLOAT4 v_nrm)
    {
        FLOAT2 res;
        res.x = v_nrm.x + (v_nrm.y * 0.00390625);
        res.y = v_nrm.z + (v_nrm.w * 0.00390625);        
        return res;        
    } 
	
	FLOAT3 Nrm_Pack(FLOAT3 v_nrm)
	{
	    return FLOAT3(saturate(v_nrm * 0.5 + 0.5 + 0.5/255.0));
	}
    
    //#define METHOD2 1   //Spherical Coordinates
    //#define METHOD4 1   //Spheremap Transform
    //#define METHOD5 1   //Cry Engine 3
    #define METHOD6 1   //Lambert Azimuthal Equal-Area Projection
    //#define METHOD7 1   //Stereographic Projection
    
    

	float3 Nrm_Unpack(float3 enc)
	{
	    //return enc * 2.0 - 1.0 - 1.0/255.0;
	    float3 n = float3(0.0, 0.0, 0.0); 
        
        #ifdef METHOD2
            float kPI = 3.1415;
			float2 ang = enc.xy * 2.0 - 1.0;
            float2 scth = 0.0;
            sincos(ang.x * kPI, scth.x, scth.y);
			float2 scphi = float2(sqrt(1.0 - ang.y * ang.y), ang.y);
			n = float3(scth.y * scphi.x, scth.x * scphi.x, scphi.y);
        #endif
        
        #ifdef METHOD4
			n.xy = -enc * enc + enc;
            n.z = -1.0;
			float f = dot(n, float3(1.0, 1.0, 0.25));
            float m = sqrt(f);
			n.xy = (enc * 8.0 - 4.0) * m;
			n.z += 8 * f;      
        #endif
        
        #ifdef METHOD5
			float2 fenc = enc * 2.0 - 1.0;
			n.z = -(dot(fenc, fenc) * 2.0 - 1.0);
			n.xy = normalize(fenc) * sqrt(1.0 - n.z * n.z);
        #endif
        
        #ifdef METHOD6
          float2 fenc = enc.xy*4-2;
          float f = dot(fenc,fenc);
          float g = sqrt(1-f/4);
          n.xy = fenc*g;
          n.z = 1-f/2;
        #endif
            
        #ifdef METHOD7
            float4 enc4 = float4(enc.xy,0,0); 
            float scale = 1.7777;
            float3 nn =
                enc4.xyz*float3(2*scale,2*scale,0) +
                float3(-scale,-scale,1);
            float g = 2.0 / dot(nn.xyz,nn.xyz);
            n.xy = g*nn.xy;
            n.z = g-1;
    
        #endif
        return n;    
	}	
	    
	float2 Nrm_Encode(float3 n)
	{
       float2 enc = float2(0.0, 0.0);
       
       #ifdef METHOD2
            float kPI = 3.1415;
            enc = (float2(atan2(n.y,n.x)/kPI, n.z)+1.0)*0.5;
       #endif
       
       #ifdef METHOD4
            float f = n.z*2+1;
            float g = dot(n,n);
            float p = sqrt(g+f);
            enc = n/p * 0.5 + 0.5;
       #endif
       
       #ifdef METHOD6 
           float f = sqrt(8*n.z+8);
           enc = n.xy / f + 0.5;
       #endif
       
       #ifdef METHOD5
            enc = normalize(n.xy) * (sqrt(-n.z*0.5+0.5));
            enc = enc*0.5+0.5;
       #endif
       
       #ifdef METHOD7
            float scale = 1.7777;
            enc = n.xy / (n.z+1);
            enc /= scale;
            enc = enc*0.5+0.5;
       #endif
       
       return enc; 
    }
	
	FLOAT4 Encode_RGB8NRM(FLOAT3 v_nrm)
	{ //input normal <-1,1>
	    FLOAT4 v_nrm_coded;
        v_nrm_coded.w = max(abs(v_nrm.x), abs(v_nrm.y));
        v_nrm_coded.w = max(abs(v_nrm.z), v_nrm_coded.w);
        v_nrm_coded.xyz = Nrm_Pack(v_nrm / v_nrm_coded.w);
        return v_nrm_coded;
	}

	FLOAT3 Decode_RGB8NRM(FLOAT4 v_nrm)
	{
		return FLOAT3(Nrm_Unpack(v_nrm.xyz)) * v_nrm.w;
	}
	
	FLOAT4 Encode_RGB8HDR(FLOAT3 v_clr)
	{
	    FLOAT4 v_clr_coded;
        FLOAT f_max = max(v_clr.x, v_clr.y);
        f_max = max(f_max, v_clr.z);
        v_clr_coded.w = FLOAT(saturate(1.0/f_max));
        v_clr_coded.xyz = v_clr * v_clr_coded.w;

        v_clr_coded.xyz = FLOAT3(sqrt(v_clr_coded.xyz)); //gamma compression - output stored in 8bit texture
        return v_clr_coded;
	}
	
	FLOAT3 Decode_RGB8HDR(FLOAT4 v_clr_coded)
	{
		v_clr_coded.xyz *= v_clr_coded.xyz; //gamma decompression - input stored in 8bit texture
		v_clr_coded.xyz /= v_clr_coded.w;
		return v_clr_coded.xyz;
	}   	
	
	#if defined(DEPTH_TMU_ON)
	
		#include<depth_sample.hlsl>
		#include<position_cs.hlsl>
		#include<position_ws.hlsl>		
	
		float4 Pos_CS(float2 v_uv, float3 v_cam_dir)
		{
			return Pos_CS(Depth_Sample(v_uv), v_cam_dir);
		}

		float4 Pos_CS(float2 v_uv, float4 v_pos_ss)
		{
			return Pos_CS(Depth_Sample(v_uv), v_pos_ss);
		}
		
		float4 Pos_WS(float2 v_uv, float3 v_cam_dir)
		{
			return Pos_WS(Depth_Sample(v_uv), v_cam_dir);
		}

		float4 Pos_WS_out_Cam_Dir_WS(in float2 v_uv, in float3 v_cam_dir, out float3 v_cam_dir_ws)
		{
			return Pos_WS_out_Cam_Dir_WS(Depth_Sample(v_uv), v_cam_dir, v_cam_dir_ws);
		}
	#endif

	#define COMMON_PS_INCLUDED 1    	 
#endif
