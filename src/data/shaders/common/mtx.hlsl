#if !defined(MTX_INCLUDED)
    #include <commonVarsLayout.hlsl>

    uniform float4 MODELVIEW_XFORM[3];
    //float4 LIGHT_XFORM_WS[4];
    //float4 LIGHT_XFORM_ES[4];
    uniform float4 COMBINED_XFORM[4];
    uniform float4 PREV_VIEWPROJ_XFORM[4];
    uniform float4 PREV_VIEW_XFORM[3];
    uniform float4 PREV_PROJECTION_XFORM[4];
    uniform float4 INVMODELVIEW_XFORM[3];
    uniform float4 INVMODEL_XFORM[3];
    uniform float4 PREV_MODEL_XFORM[3];

    float4 Mul44(float4 v_vec, float4 v_mtx[4])
    {
        float4 v_out;
        v_out.x = dot(v_vec, v_mtx[0]);
        v_out.y = dot(v_vec, v_mtx[1]);
        v_out.z = dot(v_vec, v_mtx[2]);
        v_out.w = dot(v_vec, v_mtx[3]);
        return v_out;
    }
    
    

    float3 Mul43(float4 v_vec, float4 v_mtx[3])
    {
        float3 v_out;
        v_out.x = dot(v_vec, v_mtx[0]);
        v_out.y = dot(v_vec, v_mtx[1]);
        v_out.z = dot(v_vec, v_mtx[2]);
        return v_out;
    }

    float2 Mul42(float4 v_vec, float4 v_mtx[2])
    {
        float2 v_out;
        v_out.x = dot(v_vec, v_mtx[0]);
        v_out.y = dot(v_vec, v_mtx[1]);
        return v_out;
    }

    float2 Mul42(float4 v_vec, float4 v_mtx[4])
    {
        float4 v_mtx42[2];
        v_mtx42[0] = v_mtx[0];
        v_mtx42[1] = v_mtx[1];
        return Mul42(v_vec, v_mtx42);
    }
    
    #if !defined(SHADER_PATH_OPENGL) && !defined(SHADER_PATH_ORBIS)
		half2 Mul42(half4 v_vec, half4 v_mtx[2])
        {
            half2 v_out;
            v_out.x = dot(v_vec, v_mtx[0]);
            v_out.y = dot(v_vec, v_mtx[1]);
            return v_out;
        }

        half2 Mul42(half4 v_vec, half4 v_mtx[4])
        {
            half4 v_mtx42[2];
            v_mtx42[0] = v_mtx[0];
            v_mtx42[1] = v_mtx[1];
            return Mul42(v_vec, v_mtx42);
        }

    #endif
    
    
    

    float3 Mul33(float3 v_vec, float3 v_mtx[3])
    {
        float3 v_out;
        v_out.x = dot(v_vec, v_mtx[0]);
        v_out.y = dot(v_vec, v_mtx[1]);
        v_out.z = dot(v_vec, v_mtx[2]);
        return v_out;
    }

    


    float3 Mul33T(float3 v_vec, float3 v_mtx[3])
    {
        return v_vec.x * v_mtx[0] + v_vec.y * v_mtx[1] + v_vec.z * v_mtx[2];
    }    

    float3 Mul33T(float3 v_vec, float4 v_mtx[3])
    {
        return v_vec.x * v_mtx[0].xyz + v_vec.y * v_mtx[1].xyz + v_vec.z * v_mtx[2].xyz;
    }


    float3 Mul33T(float3 v_vec, float4 v_mtx[4])
    {
        return v_vec.x * v_mtx[0].xyz + v_vec.y * v_mtx[1].xyz + v_vec.z * v_mtx[2].xyz;
    }

	#if !defined(SHADER_PATH_OPENGL) && !defined(SHADER_PATH_ORBIS)
		half3 Mul33T(half3 v_vec, half3 v_mtx[3])
		{
			return v_vec.x * v_mtx[0] + v_vec.y * v_mtx[1] + v_vec.z * v_mtx[2];
		}   


		half3 Mul33T(half3 v_vec, half4 v_mtx[3])
		{
			return v_vec.x * v_mtx[0].xyz + v_vec.y * v_mtx[1].xyz + v_vec.z * v_mtx[2].xyz;
		}

		half3 Mul33T(half3 v_vec, half4 v_mtx[4])
		{
			return v_vec.x * v_mtx[0].xyz + v_vec.y * v_mtx[1].xyz + v_vec.z * v_mtx[2].xyz;
		}
    
    #endif


    float3 Mul33(float3 v_vec, float4 v_mtx[3])
    {
        float3 v_mtx33[3];
        v_mtx33[0] = v_mtx[0].xyz;
        v_mtx33[1] = v_mtx[1].xyz;
        v_mtx33[2] = v_mtx[2].xyz;
        
        return Mul33(v_vec, v_mtx33);
    }


    float3 Mul33(float3 v_vec, float4 v_mtx[4])
    {
        float3 v_mtx33[3];
        v_mtx33[0] = v_mtx[0].xyz;
        v_mtx33[1] = v_mtx[1].xyz;
        v_mtx33[2] = v_mtx[2].xyz;

        return Mul33(v_vec, v_mtx33);
    }


    float2 Mul32(float3 v_vec, float3 v_mtx[2])
    {
        float2 v_out;
        v_out.x = dot(v_vec, v_mtx[0]);
        v_out.y = dot(v_vec, v_mtx[1]);
        return v_out;
    }

    float2 Mul32(float3 v_vec, float4 v_mtx[2])
    {
        float2 v_out;
        v_out.x = dot(v_vec, v_mtx[0].xyz);
        v_out.y = dot(v_vec, v_mtx[1].xyz);
        return v_out;
    }
	
    float4 Mul_Pos(float4 v_pos, float4 v_mtx[3])
    {
		
        float4 v_pos_out = float4(1.0, 1.0, 1.0, 1.0);
        v_pos_out.xyz = Mul43(v_pos, v_mtx);
        return v_pos_out;
    }
    float4 Mul_Pos(float4 v_pos, float4 v_mtx[4])
    {
        float4 v_mtx43[3];
        v_mtx43[0] = v_mtx[0];
        v_mtx43[1] = v_mtx[1];
        v_mtx43[2] = v_mtx[2];
        return Mul_Pos(v_pos, v_mtx43);
    }

    void InvertMTX(in float4 m_src[3], out float4 m_dst[3])
    {
        m_dst[0] = float4(0.0, 0.0, 0.0, 0.0);
        m_dst[1] = float4(0.0, 0.0, 0.0, 0.0);
        m_dst[2] = float4(0.0, 0.0, 0.0, 0.0);

    	m_dst[0].x = m_src[1].y * m_src[2].z - m_src[1].z * m_src[2].y;
        m_dst[1].x = m_src[1].z * m_src[2].x - m_src[1].x * m_src[2].z;
        m_dst[2].x = m_src[1].x * m_src[2].y - m_src[1].y * m_src[2].x;

        float f_det = m_src[0].x *  m_dst[0].x +  m_src[0].y *  m_dst[1].x + m_src[0].z *  m_dst[2].x;

        f_det = 1.0/f_det;

        m_dst[0].x *= f_det;
        m_dst[1].x *= f_det;
        m_dst[2].x *= f_det;

        m_dst[0].y = f_det * (m_src[0].z * m_src[2].y - m_src[0].y * m_src[2].z);
        m_dst[1].y = f_det * (m_src[0].x * m_src[2].z - m_src[0].z * m_src[2].x);
        m_dst[2].y = f_det * (m_src[0].y * m_src[2].x - m_src[0].x * m_src[2].y);

        m_dst[0].z = f_det * (m_src[0].y * m_src[1].z - m_src[0].z * m_src[1].y);
        m_dst[1].z = f_det * (m_src[0].z * m_src[1].x - m_src[0].x * m_src[1].z);
        m_dst[2].z = f_det * (m_src[0].x * m_src[1].y - m_src[0].y * m_src[1].x);

        float3 v_col4 = float3(m_src[0].w, m_src[1].w, m_src[2].w);

  	    m_dst[0].w = -dot(m_dst[0].xyz, v_col4);
        m_dst[1].w = -dot(m_dst[1].xyz, v_col4);
        m_dst[2].w = -dot(m_dst[2].xyz, v_col4);
    }

/* odwracanie macierzy 4x4 to zuo, poza tym ten kod i tak nie zadziala dla prawdziwych macierzy 4x4
    void InvertMTX(in float4 m_src[4], out float4 m_dst[4])
    {
		float4 m_src43[3];
		m_src43[0] = m_src[0];
		m_src43[1] = m_src[1];
		m_src43[2] = m_src[2];
		InvertMTX(m_src43, m_dst);
    }
*/
    void MulMTX(in float4 m_src1[4], in float4 m_src2[4], out float4 m_dst[4])
    {
        m_dst[0]  = m_src1[0] * m_src2[0].x;
        m_dst[0] += m_src1[1] * m_src2[0].y;
        m_dst[0] += m_src1[2] * m_src2[0].z;
        m_dst[0] += m_src1[3] * m_src2[0].w;

        m_dst[1]  = m_src1[0] * m_src2[1].x;
        m_dst[1] += m_src1[1] * m_src2[1].y;
        m_dst[1] += m_src1[2] * m_src2[1].z;
        m_dst[1] += m_src1[3] * m_src2[1].w;

        m_dst[2]  = m_src1[0] * m_src2[2].x;
        m_dst[2] += m_src1[1] * m_src2[2].y;
        m_dst[2] += m_src1[2] * m_src2[2].z;
        m_dst[2] += m_src1[3] * m_src2[2].w;

        m_dst[3]  = m_src1[0] * m_src2[3].x;
        m_dst[3] += m_src1[1] * m_src2[3].y;
        m_dst[3] += m_src1[2] * m_src2[3].z;
        m_dst[3] += m_src1[3] * m_src2[3].w;
    }

    void MulMTX(in float4 m_src1[3], in float4 m_src2[4], out float4 m_dst[4])
    {
        m_dst[0]  = m_src1[0] * m_src2[0].x;
        m_dst[0] += m_src1[1] * m_src2[0].y;
        m_dst[0] += m_src1[2] * m_src2[0].z;
        m_dst[0].w += m_src2[0].w;

        m_dst[1]  = m_src1[0] * m_src2[1].x;
        m_dst[1] += m_src1[1] * m_src2[1].y;
        m_dst[1] += m_src1[2] * m_src2[1].z;
        m_dst[1].w += m_src2[1].w;

        m_dst[2]  = m_src1[0] * m_src2[2].x;
        m_dst[2] += m_src1[1] * m_src2[2].y;
        m_dst[2] += m_src1[2] * m_src2[2].z;
        m_dst[2].w += m_src2[2].w;

        m_dst[3]  = m_src1[0] * m_src2[3].x;
        m_dst[3] += m_src1[1] * m_src2[3].y;
        m_dst[3] += m_src1[2] * m_src2[3].z;
        m_dst[3].w += m_src2[3].w;
    }

    void MulMTX(in float4 m_src1[4], in float4 m_src2[3], out float4 m_dst[4])
    {
        m_dst[0]  = m_src1[0] * m_src2[0].x;
        m_dst[0] += m_src1[1] * m_src2[0].y;
        m_dst[0] += m_src1[2] * m_src2[0].z;
        m_dst[0] += m_src1[3] * m_src2[0].w;

        m_dst[1]  = m_src1[0] * m_src2[1].x;
        m_dst[1] += m_src1[1] * m_src2[1].y;
        m_dst[1] += m_src1[2] * m_src2[1].z;
        m_dst[1] += m_src1[3] * m_src2[1].w;

        m_dst[2]  = m_src1[0] * m_src2[2].x;
        m_dst[2] += m_src1[1] * m_src2[2].y;
        m_dst[2] += m_src1[2] * m_src2[2].z;
        m_dst[2] += m_src1[3] * m_src2[2].w;

        m_dst[3] = m_src1[3];
    }

    void MulMTX(in float4 m_src1[3], in float4 m_src2[3], out float4 m_dst[3])
    {
        m_dst[0]  = m_src1[0] * m_src2[0].x;
        m_dst[0] += m_src1[1] * m_src2[0].y;
        m_dst[0] += m_src1[2] * m_src2[0].z;
        m_dst[0].w += m_src2[0].w;

        m_dst[1]  = m_src1[0] * m_src2[1].x;
        m_dst[1] += m_src1[1] * m_src2[1].y;
        m_dst[1] += m_src1[2] * m_src2[1].z;
        m_dst[1].w += m_src2[1].w;

        m_dst[2]  = m_src1[0] * m_src2[2].x;
        m_dst[2] += m_src1[1] * m_src2[2].y;
        m_dst[2] += m_src1[2] * m_src2[2].z;
        m_dst[2].w += m_src2[2].w;
    }

    #define MTX_INCLUDED 1
    
#endif
