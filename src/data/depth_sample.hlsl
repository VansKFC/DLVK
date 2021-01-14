#if !defined(DEPTH_SAMPLE_INCLUDED)

	#include <sample.hlsl>	
	
	#include <commonVarsLayout.hlsl>
	
	
	#define PS3_DepthSampleFunction texDepth2D_precise

	// ZBUFFER ////////////////////////////////////
	float ZBuffer_Calc(float f_z)
	{
		#if defined(SHADER_PATH_OPENGL)
			float f_depth = (f_z * 2.0) - 1.0;
		#else
			float f_depth = f_z;
		#endif
		
		#if defined(SHADER_PATH_PS3) || defined(SHADER_PATH_X360) || defined(SHADER_PATH_DX1x) || defined(SHADER_PATH_OPENGL)
			float2 v_frusts = f_depth * INV_FRUSTUM_0.xy + INV_FRUSTUM_0.zw;
			#if defined(SHADER_PATH_PS3) || defined(SHADER_PATH_DX1x) || defined(SHADER_PATH_OPENGL)
				f_depth = abs(v_frusts.x / -v_frusts.y); //abs prevent -inf for non set pixels
			#else
				f_depth = v_frusts.x / v_frusts.y;
			#endif
		#endif
		return f_depth;
	}        
	
	
	//DEPTH /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    float ZBuffer_Sample(Texture2DFloat t_zbuffer, SamplerState2D s_zbuffer, float2 v_uv)
    {
		float4 v_z;
		#if defined(SHADER_PATH_DX1x)   	
			#if defined(SHADER_PATH_ORBIS)
				v_z = t_zbuffer.SampleLOD( s_zbuffer, v_uv, 0.0);
			#else
				v_z = t_zbuffer.SampleLevel( s_zbuffer, v_uv, 0.0);
			#endif    
        #elif defined(SHADER_PATH_PS3)
            v_z = texDepth2D_precise(s_zbuffer, v_uv);
        #elif defined(SHADER_PATH_X360)
            asm
            {
                tfetch2D v_z.x___, v_uv.xy, s_zbuffer, MagFilter=point, MinFilter=point, UseComputedLOD=false
            };
		#elif defined(SHADER_PATH_OPENGL)
			v_z = Sample_f4(t_zbuffer, s_zbuffer, v_uv, 0.0);
        #else
            v_z = Sample_f4(t_zbuffer, s_zbuffer, v_uv, 0.0);
			FLOAT vz = Decode_Float8x4(v_z);
            v_z = FLOAT4(vz, vz, vz, vz);
        #endif
        return ZBuffer_Calc(v_z.x);
    }    
    

    float ZBuffer_SampleFast(Texture2DFloat t_zbuffer, SamplerState2D s_zbuffer, float2 v_uv)
    {
        float4 v_z;
        #if defined(SHADER_PATH_DX1x)   
			v_z = ZBuffer_Sample(t_zbuffer, s_zbuffer, v_uv);        
        #elif defined(SHADER_PATH_PS3)
            v_z = texDepth2D(s_zbuffer, v_uv);
        #elif defined(SHADER_PATH_X360)
            asm
            {
                tfetch2D v_z.x___, v_uv.xy, s_zbuffer, MagFilter=point, MinFilter=point, UseComputedLOD=false
            };
		#elif defined(SHADER_PATH_OPENGL)
			v_z = Sample_f4(t_zbuffer, s_zbuffer, v_uv, 0.0);
        #else
            v_z = Sample_f4(t_zbuffer, s_zbuffer, v_uv, 0.0);            
			FLOAT vz = Decode_Float8x4(v_z);
            v_z = FLOAT4(vz, vz, vz, vz);
        #endif
        return ZBuffer_Calc(v_z.x);
    }    
    

    // DEPTH ///////////////////////////////////////
	#if defined(DEPTH_TMU_ON)
	
		uniform Texture2DFloat T_DEPTH;
		uniform sampler2D S_DEPTH;				

		float Depth_Sample(Texture2DFloat t_dpt, SamplerState2D s_dpt, float2 v_uv)
		{
			return ZBuffer_Sample(t_dpt, s_dpt, v_uv);
		}

		float Depth_SampleFast(Texture2DFloat t_dpt, SamplerState2D s_dpt, float2 v_uv)
		{
			return ZBuffer_SampleFast(t_dpt, s_dpt, v_uv);
		}

		float4 Depth_Sample(Texture2DFloat t_dpt, SamplerState2D s_dpt, float4 v_uv)
		{
			float4 v_depths;
			v_depths.x = ZBuffer_Sample(t_dpt, s_dpt, v_uv.xy);
			v_depths.y = ZBuffer_Sample(t_dpt, s_dpt, v_uv.zy);
			v_depths.z = ZBuffer_Sample(t_dpt, s_dpt, v_uv.zw);
			v_depths.w = ZBuffer_Sample(t_dpt, s_dpt, v_uv.xw);

			return v_depths;
		}

		float Depth_Sample(float2 v_uv) { return Depth_Sample(T_DEPTH, S_DEPTH, v_uv); }
		float Depth_SampleFast(float2 v_uv) { return Depth_SampleFast(T_DEPTH, S_DEPTH, v_uv); }

		float4 Depth_Sample(float4 v_uv) { return Depth_Sample(T_DEPTH, S_DEPTH, v_uv); }
	#endif
	
	
	
	#if defined(DEPTH4_TMU_ON)
		uniform Texture2D T_DEPTH4;
		uniform sampler2D S_DEPTH4;
		#if defined(SHADER_PATH_PS3)
			#pragma texformat S_DEPTH4 FLOAT_RGBA16
		#endif			
		
		FLOAT4 Sample_h4_float(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl)
		{        
			#if defined(SHADER_PATH_DX1x)  
				#if defined(SHADER_PATH_ORBIS)
					return t_tex.SampleLOD( s_tex, v_uvwl.xy, v_uvwl.w); 
				#else
					return t_tex.SampleLevel( s_tex, v_uvwl.xy, v_uvwl.w); 
				#endif                                             
			#elif defined(SHADER_PATH_OPENGL)
				return textureLod(s_tex, float2(v_uvwl.x, 1.0-v_uvwl.y), v_uvwl.w);
			#else        
				return FLOAT4(tex2Dlod(s_tex, v_uvwl));
			#endif        
		}					
		
		FLOAT2 Depth4_MinMax_Sample(float2 v_uv) { return Sample_h4_float(T_DEPTH4, S_DEPTH4, float4(v_uv.xyy, 0.0)).xy; }		
		FLOAT Depth4_Max_Sample(float2 v_uv) { return Sample_h4_float(T_DEPTH4, S_DEPTH4, float4(v_uv.xyy, 0.0)).x; }		
		FLOAT Depth4_Min_Sample(float2 v_uv) { return Sample_h4_float(T_DEPTH4, S_DEPTH4, float4(v_uv.xyy, 0.0)).y; }		
        FLOAT2 Depth4_Weights_Sample(float2 v_uv) { return Sample_h4_float(T_DEPTH4, S_DEPTH4, float4(v_uv.xyy, 0.0)).zw; }        
        FLOAT Depth4_Avg_Sample(float2 v_uv) { return dot(Depth4_MinMax_Sample(v_uv), float2(0.5, 0.5)); }        
		FLOAT4 Depth4_Sample(float2 v_uv) { return Sample_h4_float(T_DEPTH4, S_DEPTH4, float4(v_uv.xyy, 0.0)); }
	#endif
	
	#define DEPTH_SAMPLE_INCLUDED 1    	 
#endif