#if !defined(SAMPLE_INCLUDED)

	#if defined(SHADER_PATH_DX1x)

		#define Texture2DFloat Texture2D<float>
		#define SamplerState2D SamplerState
		#define SamplerState3D SamplerState
		#define SamplerStateCUBE SamplerState

		#define sampler2D SamplerState
		#define sampler3D SamplerState
		#define samplerCUBE SamplerState


		#define Sampler2D SamplerState
		#define Sampler3D SamplerState
		#define SamplerCUBE SamplerState

	#else

		#define Texture2D int
		#define Texture3D int
		#define TextureCube int
		#define Texture2DFloat int
		#define SamplerState2D sampler2D
		#define SamplerState3D sampler3D
		#define SamplerStateCUBE samplerCUBE

		#define Sampler2D sampler2D
		#define Sampler3D sampler3D
		#define SamplerCUBE samplerCUBE

	#endif

	//tex1D/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    //tex2D /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float Sample_f1(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uv ).x;
        #elif defined(SHADER_PATH_PS3)
            return f1tex2D(s_tex, v_uv);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uv).x;
        #else
            return tex2D(s_tex, v_uv).x;
        #endif
    }


    float2 Sample_f2(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uv ).xy;
        #elif defined(SHADER_PATH_PS3)
            return f2tex2D(s_tex, v_uv);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uv).xy;
        #else
            return tex2D(s_tex, v_uv).xy;
        #endif
    }


    float3 Sample_f3(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uv ).xyz;
        #elif defined(SHADER_PATH_PS3)
            return f3tex2D(s_tex, v_uv);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uv).xyz;
        #else
            return tex2D(s_tex, v_uv).xyz;
        #endif
    }



    float4 Sample_f4(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv)
    {
		#if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uv );
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uv);
        #else
			return tex2D(s_tex, v_uv);
        #endif
    }



    FLOAT Sample_h1(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uv ).x;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h1tex2D(s_tex, v_uv);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uv).x;
        #else
            return (FLOAT)tex2D(s_tex, v_uv).x;
        #endif
    }


    FLOAT2 Sample_h2(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv)
    {
		#if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uv ).xy;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h2tex2D(s_tex, v_uv).xy;
		#elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uv).xy;
        #else
            return (FLOAT2)tex2D(s_tex, v_uv).xy;
        #endif
    }


    FLOAT3 Sample_h3(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv)
    {
		#if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uv ).xyz;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h3tex2D(s_tex, v_uv);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uv).xyz;
        #else
            return (FLOAT3)tex2D(s_tex, v_uv).xyz;
        #endif
    }

    FLOAT4 Sample_h4(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uv );
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h4tex2D(s_tex, v_uv);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uv);
        #else
            return (FLOAT4)tex2D(s_tex, v_uv);
        #endif
    }



    //tex2Dgrad /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float Sample_f1(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleGradient( s_tex, v_uv, v_ddx, v_ddy ).x;
			#else
				return t_tex.SampleGrad( s_tex, v_uv, v_ddx, v_ddy ).x;
			#endif
        #elif defined(SHADER_PATH_PS3)
            return f1tex2D(s_tex, v_uv, v_ddx, v_ddy);
        #elif defined(SHADER_PATH_OPENGL)
			return textureGrad(s_tex, v_uv, v_ddx, v_ddy).x;
        #else
            return tex2D(s_tex, v_uv, v_ddx, v_ddy).x;
        #endif
    }

    float2 Sample_f2(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleGradient( s_tex, v_uv, v_ddx, v_ddy ).xy;
			#else
				return t_tex.SampleGrad( s_tex, v_uv, v_ddx, v_ddy ).xy;
			#endif
        #elif defined(SHADER_PATH_PS3)
            return f2tex2D(s_tex, v_uv, v_ddx, v_ddy);
        #elif defined(SHADER_PATH_OPENGL)
			return textureGrad(s_tex, v_uv, v_ddx, v_ddy).xy;
        #else
            return tex2D(s_tex, v_uv, v_ddx, v_ddy).xy;
        #endif
    }
    float3 Sample_f3(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleGradient( s_tex, v_uv, v_ddx, v_ddy ).xyz;
			#else
				return t_tex.SampleGrad( s_tex, v_uv, v_ddx, v_ddy ).xyz;
			#endif
		#elif defined(SHADER_PATH_PS3)
            return f3tex2D(s_tex, v_uv, v_ddx, v_ddy);
		#elif defined(SHADER_PATH_OPENGL)
			return textureGrad(s_tex, vec2(v_uv.x, 1.0 - v_uv.y), v_ddx, v_ddy).xyz;
        #else
            return tex2D(s_tex, v_uv, v_ddx, v_ddy).xyz;
        #endif
    }
    float4 Sample_f4(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleGradient( s_tex, v_uv, v_ddx, v_ddy );
			#else
				return t_tex.SampleGrad( s_tex, v_uv, v_ddx, v_ddy );
			#endif
        #elif defined(SHADER_PATH_OPENGL)
			return textureGrad(s_tex, v_uv, v_ddx, v_ddy);
        #else
			return tex2D(s_tex, v_uv, v_ddx, v_ddy);
		#endif
    }

    FLOAT Sample_h1(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleGradient( s_tex, v_uv, v_ddx, v_ddy ).x;
			#else
				return t_tex.SampleGrad( s_tex, v_uv, v_ddx, v_ddy ).x;
			#endif
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h1tex2D(s_tex, v_uv, v_ddx, v_ddy);
        #elif defined(SHADER_PATH_OPENGL)
			return textureGrad(s_tex, v_uv, v_ddx, v_ddy).x;
        #else
            return (FLOAT)tex2D(s_tex, v_uv, v_ddx, v_ddy).x;
        #endif
    }
    FLOAT2 Sample_h2(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleGradient( s_tex, v_uv, v_ddx, v_ddy ).x;
			#else
				return t_tex.SampleGrad( s_tex, v_uv, v_ddx, v_ddy ).x;
			#endif
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h2tex2D(s_tex, v_uv, v_ddx, v_ddy);
        #elif defined(SHADER_PATH_OPENGL)
			return textureGrad(s_tex, v_uv, v_ddx, v_ddy).xy;
        #else
            return (FLOAT2)tex2D(s_tex, v_uv, v_ddx, v_ddy).xy;
        #endif
    }
    FLOAT3 Sample_h3(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleGradient( s_tex, v_uv, v_ddx, v_ddy ).xyz;
			#else
				return t_tex.SampleGrad( s_tex, v_uv, v_ddx, v_ddy ).xyz;
			#endif
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h3tex2D(s_tex, v_uv, v_ddx, v_ddy);
        #elif defined(SHADER_PATH_OPENGL)
			return textureGrad(s_tex, v_uv, v_ddx, v_ddy).xyz;
        #else
            return (FLOAT3)tex2D(s_tex, v_uv, v_ddx, v_ddy).xyz;
        #endif
    }
    FLOAT4 Sample_h4(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleGradient( s_tex, v_uv, v_ddx, v_ddy );
			#else
				return t_tex.SampleGrad( s_tex, v_uv, v_ddx, v_ddy );
			#endif
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h4tex2D(s_tex, v_uv, v_ddx, v_ddy);
        #elif defined(SHADER_PATH_OPENGL)
			return textureGrad(s_tex, v_uv, v_ddx, v_ddy);
        #else
            return (FLOAT4)tex2D(s_tex, v_uv, v_ddx, v_ddy);
        #endif
    }

	//tex1D  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	float Sample_f1(Texture2D t_tex, SamplerState2D s_tex, float v_uv)
    {
        return Sample_f1(t_tex, s_tex, float2(v_uv, 0.0));
    }


    float2 Sample_f2(Texture2D t_tex, SamplerState2D s_tex, float v_uv)
    {
		return Sample_f2(t_tex, s_tex, float2(v_uv, 0.0));
    }


    float3 Sample_f3(Texture2D t_tex, SamplerState2D s_tex, float v_uv)
    {
		return Sample_f3(t_tex, s_tex, float2(v_uv, 0.0));
    }



    float4 Sample_f4(Texture2D t_tex, SamplerState2D s_tex, float v_uv)
    {
		return Sample_f4(t_tex, s_tex, float2(v_uv, 0.0));
    }



    FLOAT Sample_h1(Texture2D t_tex, SamplerState2D s_tex, float v_uv)
    {
		return Sample_h1(t_tex, s_tex, float2(v_uv, 0.0));
    }


    FLOAT2 Sample_h2(Texture2D t_tex, SamplerState2D s_tex, float v_uv)
    {
		return Sample_h2(t_tex, s_tex, float2(v_uv, 0.0));
    }


    FLOAT3 Sample_h3(Texture2D t_tex, SamplerState2D s_tex, float v_uv)
    {
		return Sample_h3(t_tex, s_tex, float2(v_uv, 0.0));
    }

    FLOAT4 Sample_h4(Texture2D t_tex, SamplerState2D s_tex, float v_uv)
    {
        return Sample_h4(t_tex, s_tex, float2(v_uv, 0.0));
    }




    //tex2Dlod /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float4 Sample_f4(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleLOD( s_tex, v_uvwl.xy, v_uvwl.w);
			#else
				return t_tex.SampleLevel( s_tex, v_uvwl.xy, v_uvwl.w);
			#endif
        #elif defined(SHADER_PATH_OPENGL)
			return textureLod(s_tex, v_uvwl.xy, v_uvwl.w);
        #else
			return tex2Dlod(s_tex, v_uvwl);
		#endif
    }

    float3 Sample_f3(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl) { return Sample_f4(t_tex, s_tex, v_uvwl).xyz; }
    float2 Sample_f2(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl) { return Sample_f4(t_tex, s_tex, v_uvwl).xy; }
    float Sample_f1(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl) { return Sample_f4(t_tex, s_tex, v_uvwl).x; }



    FLOAT4 Sample_h4(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl)
    {
		#if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleLOD( s_tex, v_uvwl.xy, v_uvwl.w);
			#else
				return t_tex.SampleLevel( s_tex, v_uvwl.xy, v_uvwl.w);
			#endif
        #elif defined(SHADER_PATH_OPENGL)
			return textureLod(s_tex, v_uvwl.xy, v_uvwl.w);
        #else
			return FLOAT4(tex2Dlod(s_tex, v_uvwl));
		#endif
    }


    FLOAT3 Sample_h3(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl) { return Sample_h4(t_tex, s_tex, v_uvwl).xyz; }
    FLOAT2 Sample_h2(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl) { return Sample_h4(t_tex, s_tex, v_uvwl).xy; }
    FLOAT Sample_h1(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwl) { return Sample_h4(t_tex, s_tex, v_uvwl).x; }

    float4 Sample_f4(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_f4(t_tex, s_tex, float4(v_uv.xyy, f_lod)); }
    float3 Sample_f3(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_f4(t_tex, s_tex, v_uv, f_lod).xyz; }
    float2 Sample_f2(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_f4(t_tex, s_tex, v_uv, f_lod).xy; }
    float Sample_f1(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_f4(t_tex, s_tex, v_uv, f_lod).x; }

    FLOAT4 Sample_h4(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_h4(t_tex, s_tex, float4(v_uv.xyy, f_lod)); }
    FLOAT3 Sample_h3(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_h4(t_tex, s_tex, v_uv, f_lod).xyz; }
    FLOAT2 Sample_h2(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_h4(t_tex, s_tex, v_uv, f_lod).xy; }
    FLOAT Sample_h1(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_h4(t_tex, s_tex, v_uv, f_lod).x; }



    //tex2Dproj /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float SamplePROJ_f1(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvwz.xy/v_uvwz.w ).x;
        #elif defined(SHADER_PATH_PS3)
            //return f1tex2Dproj(s_tex, v_uvwz);
            return tex2Dproj(s_tex, v_uvwz).x;
		#elif defined(SHADER_PATH_OPENGL)
			return textureProj(s_tex, v_uvwz).x;
        #else
            return tex2Dproj(s_tex, v_uvwz).x;
        #endif
    }

    float2 SamplePROJ_f2(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvwz.xy/v_uvwz.w ).xy;
        #elif defined(SHADER_PATH_PS3)
//            return f2tex2Dproj(s_tex, v_uvwz);
            return tex2Dproj(s_tex, v_uvwz).xy;
        #elif defined(SHADER_PATH_OPENGL)
			return textureProj(s_tex, v_uvwz).xy;
        #else
            return tex2Dproj(s_tex, v_uvwz).xy;
        #endif
    }
    float3 SamplePROJ_f3(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvwz.xy/v_uvwz.w ).xyz;
        #elif defined(SHADER_PATH_PS3)
//            return f3tex2Dproj(s_tex, v_uvwz);
            return tex2Dproj(s_tex, v_uvwz).xyz;
        #elif defined(SHADER_PATH_OPENGL)
			return textureProj(s_tex, v_uvwz).xyz;
        #else
            return tex2Dproj(s_tex, v_uvwz).xyz;
        #endif
    }
    float4 SamplePROJ_f4(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvwz.xy/v_uvwz.w );
        #elif defined(SHADER_PATH_OPENGL)
			return textureProj(s_tex, v_uvwz);
        #else
			 return tex2Dproj(s_tex, v_uvwz);
		#endif
    }

    FLOAT SamplePROJ_h1(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvwz.xy/v_uvwz.w ).x;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
//            return h1tex2Dproj(s_tex, v_uvwz);
            return tex2Dproj(s_tex, v_uvwz).x;
        #elif defined(SHADER_PATH_OPENGL)
			return textureProj(s_tex, v_uvwz).x;
        #else
            return (FLOAT)tex2Dproj(s_tex, v_uvwz).x;
        #endif
    }
    FLOAT2 SamplePROJ_h2(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvwz.xy/v_uvwz.w ).xy;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
//            return h2tex2Dproj(s_tex, v_uvwz);
            return tex2Dproj(s_tex, v_uvwz).xy;
		#elif defined(SHADER_PATH_OPENGL)
			return textureProj(s_tex, v_uvwz).xy;
        #else
            return (FLOAT2)tex2Dproj(s_tex, v_uvwz).xy;
        #endif
    }
    FLOAT3 SamplePROJ_h3(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvwz.xy/v_uvwz.w ).xyz;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
//            return h3tex2Dproj(s_tex, v_uvwz);
            return tex2Dproj(s_tex, v_uvwz).xyz;
        #elif defined(SHADER_PATH_OPENGL)
			return textureProj(s_tex, v_uvwz).xyz;
        #else
            return (FLOAT3)tex2Dproj(s_tex, v_uvwz).xyz;
        #endif
    }
    FLOAT4 SamplePROJ_h4(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvwz.xy/v_uvwz.w );
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
//            return h4tex2Dproj(s_tex, v_uvwz);
            return tex2Dproj(s_tex, v_uvwz);
		#elif defined(SHADER_PATH_OPENGL)
			return textureProj(s_tex, v_uvwz);
        #else
            return (FLOAT4)tex2Dproj(s_tex, v_uvwz);
        #endif
    }


    //tex3D /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float Sample_f1(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).x;
        #elif defined(SHADER_PATH_PS3)
            return f1tex3D(s_tex, v_uvw);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).x;
        #else
            return tex3D(s_tex, v_uvw).x;
        #endif
    }

    float2 Sample_f2(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).xy;
        #elif defined(SHADER_PATH_PS3)
            return f2tex3D(s_tex, v_uvw);
		#elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).xy;
        #else
            return tex3D(s_tex, v_uvw).xy;
        #endif
    }
    float3 Sample_f3(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).xyz;
        #elif defined(SHADER_PATH_PS3)
            return f3tex3D(s_tex, v_uvw);
		#elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).xyz;
        #else
            return tex3D(s_tex, v_uvw).xyz;
        #endif
    }
    float4 Sample_f4(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw );
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw);
        #else
			 return tex3D(s_tex, v_uvw);
		#endif
    }

    FLOAT Sample_h1(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).x;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h1tex3D(s_tex, v_uvw);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).x;
        #else
            return (FLOAT)tex3D(s_tex, v_uvw).x;
        #endif
    }
    FLOAT2 Sample_h2(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).xy;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h2tex3D(s_tex, v_uvw);
		#elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).xy;
        #else
            return (FLOAT2)tex3D(s_tex, v_uvw).xy;
        #endif
    }
    FLOAT3 Sample_h3(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).xyz;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h3tex3D(s_tex, v_uvw);
		#elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).xyz;
        #else
            return (FLOAT3)tex3D(s_tex, v_uvw).xyz;
        #endif
    }
    FLOAT4 Sample_h4(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw );
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h4tex3D(s_tex, v_uvw);
		#elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw);
        #else
            return (FLOAT4)tex3D(s_tex, v_uvw);
        #endif
    }


    //tex3Dlod /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float4 Sample_f4(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw, float f_lod)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleLOD( s_tex, v_uvw, f_lod);
			#else
				return t_tex.SampleLevel( s_tex, v_uvw, f_lod);
			#endif
        #elif defined(SHADER_PATH_OPENGL)
			return textureLod(s_tex, v_uvw, f_lod);
        #else
			return tex3Dlod(s_tex, float4(v_uvw, f_lod));
		#endif
    }



    float3 Sample_f3(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw, float f_lod) { return Sample_f4(t_tex, s_tex, v_uvw, f_lod).xyz; }
    float2 Sample_f2(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw, float f_lod) { return Sample_f4(t_tex, s_tex, v_uvw, f_lod).xy; }
    float Sample_f1(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw, float f_lod) { return Sample_f4(t_tex, s_tex, v_uvw, f_lod).x; }

    FLOAT4 Sample_h4(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw, float f_lod)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleLOD( s_tex, v_uvw, f_lod);
			#else
				return t_tex.SampleLevel( s_tex, v_uvw, f_lod);
			#endif
        #elif defined(SHADER_PATH_OPENGL)
			return textureLod(s_tex, v_uvw, f_lod);
        #else
			return FLOAT4(tex3Dlod(s_tex, float4(v_uvw, f_lod)));
		#endif
    }

    FLOAT3 Sample_h3(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw, float f_lod) { return Sample_h4(t_tex, s_tex, v_uvw, f_lod).xyz; }
    FLOAT2 Sample_h2(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw, float f_lod) { return Sample_h4(t_tex, s_tex, v_uvw, f_lod).xy; }
    FLOAT Sample_h1(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw, float f_lod) { return Sample_h4(t_tex, s_tex, v_uvw, f_lod).x; }



    //texCUBE /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float SampleCUBE_f1(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw)
    {
		#if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).x;
        #elif defined(SHADER_PATH_PS3)
            return f1texCUBE(s_tex, v_uvw);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).x;
        #else
            return texCUBE(s_tex, v_uvw).x;
        #endif
    }


    float2 SampleCUBE_f2(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).xy;
        #elif defined(SHADER_PATH_PS3)
            return f2texCUBE(s_tex, v_uvw);
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).xy;
        #else
            return texCUBE(s_tex, v_uvw).xy;
        #endif
    }
    float3 SampleCUBE_f3(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).xyz;
        #elif defined(SHADER_PATH_PS3)
            return f3texCUBE(s_tex, v_uvw);
         #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).xyz;
        #else
            return texCUBE(s_tex, v_uvw).xyz;
        #endif
    }
    float4 SampleCUBE_f4(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw );
        #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw);
        #else
			return texCUBE(s_tex, v_uvw);
		#endif
    }

    FLOAT SampleCUBE_h1(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).x;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h1texCUBE(s_tex, v_uvw);
         #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).x;
        #else
            return (FLOAT)texCUBE(s_tex, v_uvw).x;
        #endif
    }
    FLOAT2 SampleCUBE_h2(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).xy;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h2texCUBE(s_tex, v_uvw);
         #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).xy;
        #else
            return (FLOAT2)texCUBE(s_tex, v_uvw).xy;
        #endif
    }
    FLOAT3 SampleCUBE_h3(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw ).xyz;
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h3texCUBE(s_tex, v_uvw);
         #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw).xyz;
        #else
            return (FLOAT3)texCUBE(s_tex, v_uvw).xyz;
        #endif
    }
    FLOAT4 SampleCUBE_h4(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw)
    {
        #if defined(SHADER_PATH_DX1x)
			return t_tex.Sample( s_tex, v_uvw );
        #elif defined(SHADER_PATH_PS3) && defined(HALF_ON)
            return h4texCUBE(s_tex, v_uvw);
         #elif defined(SHADER_PATH_OPENGL)
			return texture(s_tex, v_uvw);
        #else
            return (FLOAT4)texCUBE(s_tex, v_uvw);
        #endif
    }


    //texCUBElod /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float4 SampleCUBE_f4(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleLOD(s_tex, v_uvw, f_lod);
			#else
				return t_tex.SampleLevel(s_tex, v_uvw, f_lod);
			#endif
        #elif defined(SHADER_PATH_OPENGL)
			return textureLod(s_tex, v_uvw, f_lod);
        #else
			return texCUBElod(s_tex, float4(v_uvw, f_lod));
		#endif
    }

    float3 SampleCUBE_f3(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod) { return SampleCUBE_f4(t_tex, s_tex, v_uvw, f_lod).xyz; }
    float2 SampleCUBE_f2(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod) { return SampleCUBE_f4(t_tex, s_tex, v_uvw, f_lod).xy; }
    float SampleCUBE_f1(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod) { return SampleCUBE_f4(t_tex, s_tex, v_uvw, f_lod).x; }

    FLOAT4 SampleCUBE_h4(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod)
    {
        #if defined(SHADER_PATH_DX1x)
			#if defined(SHADER_PATH_ORBIS)
				return t_tex.SampleLOD(s_tex, v_uvw, f_lod);
			#else
				return t_tex.SampleLevel(s_tex, v_uvw, f_lod);
			#endif
        #elif defined(SHADER_PATH_OPENGL)
			return textureLod(s_tex, v_uvw, f_lod);
        #else
			return FLOAT4(texCUBElod(s_tex, float4(v_uvw, f_lod)));
		#endif
    }

    FLOAT3 SampleCUBE_h3(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod) { return SampleCUBE_h4(t_tex, s_tex, v_uvw, f_lod).xyz; }
    FLOAT2 SampleCUBE_h2(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod) { return SampleCUBE_h4(t_tex, s_tex, v_uvw, f_lod).xy; }
    FLOAT SampleCUBE_h1(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod) { return SampleCUBE_h4(t_tex, s_tex, v_uvw, f_lod).x; }

    //other /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    FLOAT4 Sample(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv) { return Sample_h4(t_tex, s_tex, v_uv); }
    FLOAT4 Sample(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float f_lod) { return Sample_h4(t_tex, s_tex, v_uv, f_lod); }
    FLOAT4 Sample(Texture2D t_tex, SamplerState2D s_tex, float2 v_uv, float2 v_ddx, float2 v_ddy) { return Sample_h4(t_tex, s_tex, v_uv, v_ddx, v_ddy); }

    FLOAT4 SamplePROJ(Texture2D t_tex, SamplerState2D s_tex, float4 v_uvwz) { return SamplePROJ_h4(t_tex, s_tex, v_uvwz); }

    FLOAT4 Sample(Texture3D t_tex, SamplerState3D s_tex, float3 v_uvw) { return Sample_h4(t_tex, s_tex, v_uvw); }

    FLOAT4 SampleCUBE(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw) { return SampleCUBE_h4(t_tex, s_tex, v_uvw); }
    FLOAT4 SampleCUBE(TextureCube t_tex, SamplerStateCUBE s_tex, float3 v_uvw, float f_lod) { return SampleCUBE_h4(t_tex, s_tex, v_uvw, f_lod); }

	#if defined(STEREO_TMU_ON)
		CONST_FLOAT4 STEREO_PARAM;

		uniform Texture2D t_stereo;
		uniform sampler2D s_stereo;

		float stereoXOffsetNPOS(float f_depth)
		{
			float stereoSide = Sample_f1(t_stereo, s_stereo, float2(0,0)); //getStereoSide()

			float param = STEREO_PARAM.x * f_depth + STEREO_PARAM.y;

			return stereoSide * param;
		}
	#endif


    // NORMAL ///////////////////////////////////////
	#if defined(NORMAL_TMU_ON)
		uniform Texture2D T_NRM;
		uniform sampler2D S_NRM;
		#if defined(SHADER_PATH_PS3)
			#pragma texformat S_NRM ARGB8
		#endif
		float4 Normal_Sample(float2 v_uv) { return Sample(T_NRM, S_NRM, v_uv, 0.0); }
		float4 Normal_bx2_Sample(float2 v_uv) { return Normal_Sample(v_uv) * 2.0 - 1.0; }
		float3 Normal_Sample_h3(float2 v_uv) { return Sample_h3(T_NRM, S_NRM, v_uv, 0.0); }
		float3 Normal_bx2_Sample_h3(float2 v_uv) { return Normal_Sample_h3(v_uv) * 2.0 - 1.0; }
	#endif


    // COLOR ///////////////////////////////////////
	#if defined(SPECULAR_TMU_ON)
		uniform Texture2D T_GBUFFER_SPECULAR;
		uniform sampler2D S_GBUFFER_SPECULAR;

		float4 Specular_Sample(float2 uv) { return Sample(T_GBUFFER_SPECULAR, S_GBUFFER_SPECULAR, uv, 0.0); }
	#endif
	#if defined(DIFFUSE_TMU_ON)
		uniform Texture2D T_GBUFFER_DIFFUSE;
		uniform sampler2D S_GBUFFER_DIFFUSE;

		float4 Diffuse_Sample(float2 uv) { return Sample(T_GBUFFER_DIFFUSE, S_GBUFFER_DIFFUSE, uv, 0.0); }
	#endif
	#if defined(COLOR_TMU_ON)

		uniform Texture2D T_CLR;
		uniform sampler2D S_CLR;

		#if defined(SHADER_PATH_PS3)
			#pragma texformat S_CLR ARGB8
		#endif
		FLOAT4 Color_Sample(FLOAT2 v_uv) { return Sample(T_CLR, S_CLR, v_uv, 0.0); }
		FLOAT3 Color_Sample_h3(FLOAT2 v_uv) { return Sample_h3(T_CLR, S_CLR, v_uv, 0.0); }
	#endif
    #define SAMPLE_INCLUDED 1


#endif

