#if !defined(POSITION_WS_INCLUDED)
float4 Pos_WS(float f_depth, float3 v_cam_dir){
float4 v_pos_ws = float4(1.0,1.0,1.0,1.0);
v_pos_ws.xyz = CAMERA_POS_WS.xyz - v_cam_dir * f_depth;
#if defined(PIXELSHADER) && defined(STEREO_TMU_ON)
v_pos_ws.x += stereoXOffsetNPOS(f_depth);
#endif
return v_pos_ws;}
float4 Pos_WS_out_Cam_Dir_WS(in float f_depth, in float3 v_cam_dir, out float3 v_cam_dir_ws){
v_cam_dir_ws = v_cam_dir * f_depth;
float4 v_pos_ws = float4(1.0, 1.0, 1.0, 1.0);
v_pos_ws.xyz = CAMERA_POS_WS.xyz - v_cam_dir_ws;
#if defined(PIXELSHADER) && defined(STEREO_TMU_ON)
v_pos_ws.x += stereoXOffsetNPOS(f_depth);
#endif
return v_pos_ws;}
#define POSITION_WS_INCLUDED 1
#endif