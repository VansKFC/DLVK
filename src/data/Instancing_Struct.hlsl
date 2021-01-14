#if defined(INSTANCING_ON)
    #if defined(INSTANCING_VS_ON) || defined(INSTANCING_VSPLUS_ON)
        int VertexIndex : INDEX;
    #elif defined(INSTANCING_SM30_ON)
        float4 MODEL_XFORM_I_R0  : TEXCOORD4;
        float4 MODEL_XFORM_I_R1  : TEXCOORD5;
        float4 MODEL_XFORM_I_R2  : TEXCOORD6;
        float4 v_const_0         : TEXCOORD7;
    #endif
#endif
