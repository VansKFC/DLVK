#if !defined( ENGINEDEFS_INCLUDED )
    #define ENGINEDEFS_INCLUDED 1

    // shadow quality
    #define SQ_LOW 1
    #define SQ_HIGH 2

    // hierarchical shadowmap mode
    #define HSMM_XENON 1
    #define HSMM_NVIDIA 2
    #define HSMM_ATI 3
    #define HSMM_DX11 4

    // keep in sync with code!
    struct SLightInstanceData
    {
        float4  LIGHT_XFORM_ES[4];  // view->light
        float4  CLIP_XFORM_ES[3];   // view->clip box
        float4  MODELVIEW_XFORM[3];     // light->world
        float4  SHADOW_SCALE_BIAS;  // xy - scale, zw - bias
        float4  LIGHT_COLOR;        // xyz - color, w - intensity
    };

    //SInstanceData INSTANCE_DATA : register(c0);

	// Force recompilation ;) Joke ;)
	
#endif
