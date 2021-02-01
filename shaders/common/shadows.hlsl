#if !defined(SHADOWS_INCLUDED)
#define SHADOWS_INCLUDED 1
#if defined(SHADER_PATH_OPENGL)
$if defined(OPENGL_AMD_SHADOW_HOOK)
layout(binding=15) uniform sampler2D s_shadowmap;
$elif !defined(OPENGL_LAYOUT_BINDING)
uniform sampler2DShadow s_shadowmap;
$else
layout(binding=15) uniform sampler2DShadow s_shadowmap;
$endif
#else
SamplerComparisonState s_shadowmap;
Texture2D<float> t_shadowmap;	
#endif
CONST_FLOAT4 TEX_INV_SIZE_s_shadowmap;
CONST_FLOAT4 Z_RANGE_SWAP_PARAMS;
float Sample_Shadowmap(float3 v_uv){
float uv_z = Z_RANGE_SWAP_PARAMS.x * v_uv.z + Z_RANGE_SWAP_PARAMS.y;
#if defined(SHADER_PATH_ORBIS)
float f_shadowmap = t_shadowmap.SampleCmpLOD0(s_shadowmap,v_uv.xy,uv_z);
#elif defined(SHADER_PATH_OPENGL)
$if defined(OPENGL_AMD_SHADOW_HOOK)
float f_shadowmap = texture(s_shadowmap,v_uv.xy).x;
f_shadowmap = uv_z < f_shadowmap ? 1.0 : 0.0;
$else
float f_shadowmap = texture(s_shadowmap,float3(v_uv.xy,uv_z));
$endif
#else
float f_shadowmap = t_shadowmap.SampleCmpLevelZero(s_shadowmap,v_uv.xy,uv_z);
#endif
return Z_RANGE_SWAP_PARAMS.x * f_shadowmap + Z_RANGE_SWAP_PARAMS.y;}
float Sample_Shadowmap(float3 uv,float offset_x,float offset_y){
float3 uv_offseted = uv;
uv_offseted.xy += TEX_INV_SIZE_s_shadowmap.xy * float2(offset_x,offset_y);
return Sample_Shadowmap(uv_offseted);}
float Shadows_Blur16(float3 uv,float kernel_scale){
float2 offset[16];
offset[0] = float2(-1.5,-1.5);
offset[1] = float2(-1.5,-0.5);
offset[2] = float2(-1.5,0.5);
offset[3] = float2(-1.5,1.5);
offset[4] = float2(-0.5,-1.5);
offset[5] = float2(-0.5,-0.5);
offset[6] = float2(-0.5,0.5);
offset[7] = float2(-0.5,1.5);
offset[8] = float2(0.5,-1.5);
offset[9] = float2(0.5,-0.5);
offset[10] = float2(0.5,0.5);
offset[11] = float2(0.5,1.5);
offset[12] = float2(1.5,-1.5);
offset[13] = float2(1.5,-0.5);
offset[14] = float2(1.5,0.5);
offset[15] = float2(1.5,1.5);
float shadow = 0.0;
float3 offset_scale = float3(TEX_INV_SIZE_s_shadowmap.xy * kernel_scale, 0.0);
for(int i = 0; i < 16; i++){
float3 sample_uv = uv + offset[i].xyy * offset_scale;
shadow += Sample_Shadowmap(sample_uv) * 0.0625;}
return smoothstep(0.0,1.0,shadow);}
float Shadows_Blur4(float3 uv,float kernel_scale){
float2 offset[4];
offset[0] = float2(-kernel_scale, -kernel_scale);
offset[1] = float2(kernel_scale, -kernel_scale);
offset[2] = float2(kernel_scale,  kernel_scale);
offset[3] = float2(-kernel_scale,  kernel_scale);
float shadow = 0.0;
float3 sample_uv = uv;
for(int i = 0; i < 4; i++){
sample_uv.xy = uv.xy + offset[i] * TEX_INV_SIZE_s_shadowmap.xy;
shadow += Sample_Shadowmap(sample_uv) * 0.25;}
return smoothstep(0.0,1.0,shadow);}
#if defined(D_HSM_XFORM_ES)
float3 PosCamera2Shadow(float4 pos_cs){
return Mul43(pos_cs,D_HSM_XFORM_ES);}
float3 ShadowUV(float3 pos_hsm){
float3 uv = pos_hsm;
uv.xy = uv.xy * SwizzleXX(0.5) + SwizzleXX(0.5);
return uv;}
float3 ShadowUV(float4 pos_cs){
float3 pos_hsm = PosCamera2Shadow(pos_cs);
return ShadowUV(pos_hsm);}
float3 ShadowUV_bias(float3 pos_hsm,float3 bias_dir_cs,float bias,float z_scale){
float3 uv = ShadowUV(pos_hsm);
float3 bias_dir_hsm = Mul33(bias_dir_cs, D_HSM_XFORM_ES);
float3 bias_dir_n_hsm = normalize(bias_dir_hsm);
float2 offset_xy = TEX_INV_SIZE_s_shadowmap.xy * SwizzleXX(bias);
float offset = length(offset_xy);
float3 offset_dir = offset * bias_dir_n_hsm;
uv += offset_dir * float3(1.0,1.0,z_scale);
return uv;}
float3 ShadowUV_bias(float4 pos_cs,float3 bias_dir_cs,float bias,float z_scale){
float3 pos_hsm = ShadowUV(pos_cs);
return ShadowUV_bias(pos_hsm,bias_dir_cs,bias,z_scale);}
float3 ShadowUV_bias(float3 pos_hsm,float3 bias_dir_cs,float bias){
return ShadowUV_bias(pos_hsm,bias_dir_cs,bias,1.0);}
float3 ShadowUV_bias(float3 pos_hsm,float3 bias_dir_cs){
return ShadowUV_bias(pos_hsm,bias_dir_cs,3.0);}
float ShadowAtPos(float4 pos_cs){
float3 pos_hsm = PosCamera2Shadow(pos_cs);
float3 uv = ShadowUV(pos_hsm);
return Sample_Shadowmap(uv);}
float ShadowAtPos(float4 pos_cs,float3 bias_dir_cs,float offset_scale){
float3 pos_hsm = PosCamera2Shadow(pos_cs);
float3 uv = ShadowUV_bias(pos_hsm, bias_dir_cs, offset_scale);
return Sample_Shadowmap(uv);}
float ShadowAtPos_Fade(float4 pos_cs,float3 bias_dir_cs,float offset_scale){
float3 pos_hsm = PosCamera2Shadow(pos_cs);
float3 uv = ShadowUV_bias(pos_hsm,bias_dir_cs,offset_scale);
float shadow = Sample_Shadowmap(uv);
float fade_mask = saturate(dot(pos_hsm.xy,pos_hsm.xy)); 
float3 cam_pos_hsm = float3(D_HSM_XFORM_ES[0].w,D_HSM_XFORM_ES[1].w,D_HSM_XFORM_ES[2].w);
float pixel_distance = distance(pos_hsm,cam_pos_hsm);
pixel_distance /= length(cam_pos_hsm);
pixel_distance = saturate(pixel_distance * 2.0 - 2.0);
shadow = saturate(shadow + fade_mask * pixel_distance);
return shadow;}
float ShadowAtPos(float4 pos_cs,float3 bias_dir_cs){
float3 pos_hsm = PosCamera2Shadow(pos_cs);
float3 uv = ShadowUV_bias(pos_hsm,bias_dir_cs);
return Sample_Shadowmap(uv);}
float Shadow4AtPos(float4 pos_cs,float3 bias_dir_cs,float offset_scale,float kernel_scale){
float3 pos_hsm = PosCamera2Shadow(pos_cs);
float3 uv = ShadowUV_bias(pos_hsm,bias_dir_cs,offset_scale);
return Shadows_Blur4(uv,kernel_scale);}
float Shadow16AtPos(float4 pos_cs,float3 bias_dir_cs,float offset_scale,float kernel_scale){
float3 pos_hsm = PosCamera2Shadow(pos_cs);
float3 uv = ShadowUV_bias(pos_hsm,bias_dir_cs,offset_scale,0.25);
return Shadows_Blur16(uv,kernel_scale);}
#endif
#endif
