#if !defined(POS_OUT_SPRITE_INCLUDED)
    #include <mtx.hlsl>
	#include <commonVarsLayout.hlsl>

    float4 Pos_Out_Tri(float4 pos)
    {
		#if defined( SHADER_PATH_OPENGL )
			return float4(  pos.x>0.0 ? 3.0 : -1.0, pos.y>0.0 ? 1.0 : -3.0, 0.0, 1.0 );		
		#else
			return ( pos.xyzw > SwizzleXXXX(0.0) ) ? float4(3.0, 1.0, 0.0, 1.0) : float4(-1.0, -3.0, 0.0, 1.0);
		#endif
    }
    float2 UV_from_Tri(float4 pos)
    {
		#if defined( SHADER_PATH_OPENGL )
			return float2(  pos.x>0.0 ? 2.0 : 0.0, pos.y>0.0 ? 0.0 : 2.0 );		
		#else
			return ( pos.xy > SwizzleXX(0.0) ) ? float2(2.0, 0.0) : float2(0.0, 2.0);
		#endif
    }
	
    float4 Pos_Out_Sprite(float4 v_pos)
    {
		#if defined( SHADER_PATH_OPENGL )
			float4 v_pos_cpy = v_pos;
			v_pos_cpy.xy = v_pos.xy * POS_2D.xy + POS_2D.zw;
			return v_pos_cpy;
		#else
			v_pos.xy = v_pos.xy * POS_2D.xy + POS_2D.zw;
			return v_pos;		
		#endif
    }
    float4 Pos_Out_Sprite3D(float4 v_pos)
    {
		#if defined( SHADER_PATH_OPENGL )
			float4 v_pos_cpy = v_pos;
			v_pos_cpy = Mul_Pos(v_pos_cpy, MODEL_XFORM);
			return Pos_Out_Sprite(v_pos_cpy);
		#else
		    v_pos = Mul_Pos(v_pos, MODEL_XFORM);
			return Pos_Out_Sprite(v_pos);
		#endif
    }
    float4 Pos_Out_PP(float4 v_pos)
    {
        float3 POS = float3(1.0, -1.0, 0.5);
        return IF(greaterThan(v_pos, float4(0.0, 0.0, 0.0, 0.0)), POS.xxzx, POS.yyzx);
    }
    #define POS_OUT_SPRITE_INCLUDED 1
    
#endif

