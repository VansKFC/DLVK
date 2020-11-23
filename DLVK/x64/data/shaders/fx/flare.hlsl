//Going to Optimize this..
using engineflags;
using settemplates;
using tmu;

template
{
	category Basic
	{
		class Textures
		{
			string_dat s_tex = "" : editor(ImageFileNameEditor), display(s_tex);
		}
		class Colors
		{
			vec3_dat v_color = vec(1.0, 1.0, 1.0) : display(v_color);
			float_dat f_intensity = 1.0 : display(f_intensity);
		}
		class Fading
		{
			float_dat f_fade_angle_max = -1.0 : display(Fade angle max);
			float_dat f_fade_angle_min = -1.0 : display(Fade angle min);
			float_dat f_fade_far_max = 0.0 : display(Fade far max);
			float_dat f_fade_far_min = 0.0 : display(Fade far min);
			float_dat f_fade_near_max = 0.0 : display(Fade near max);
			float_dat f_fade_near_min = 0.0 : display(Fade near min);
			float_dat f_fade_screen_max = 8.0 : display(Fade screen max);
			float_dat f_fade_screen_min = 1.0 : display(Fade screen min);
			float_dat f_dpt_bias = 0.0 : display(Depth test bias [m]);
		}
	}
	category Advanced
	{
		class Special
		{
			bool_dat b_sun_on = FALSE : display(Flare for sun);
			bool_dat b_depth_test_on = TRUE : display(Depth test enabled);
			bool_dat b_glow_on = FALSE : display(b_glow_on);
			float_dat f_offset_scale = 0.0 : display(f_offset_scale);
			float_dat f_size_scale = 1.0 : display(f_size_scale);
		}
		class Multiflare
		{
			vec3_dat v_extent = vec(0.0, 0.0, 0.0) : display(v_extent);
		}
		class Technique
		{
			string_dat technique = "glow_1" : converter("\"glow_1\"", "\"ems\"");
		}
	}

    templatebody()
    {
		platform("*", "none; instancing");

		tech(technique)
        {
			bool_dat fade_angle_on = (f_fade_angle_max > f_fade_angle_min);
			bool_dat extent_on = ((v_extent.x > 0.0) | (v_extent.y > 0.0) | (v_extent.z > 0.0));
			bool_dat glow_1_on = (technique == "glow_1");

			Cull(NONE);
			BlendFunc(ONE, ONE, ZERO, ONE);
			if(technique == "glow_1")
			{
				DepthFunc(ALWAYS, FALSE);
			}
			if(technique == "ems")
			{
                Define("D_EMS_ON", 1);
				DepthFunc(LEQUAL, FALSE);
			}

			Input I_UV_0 = new InputFloat2("TEXCOORD0");
			X_UV_0 = SetTexcoord2();
			X_CLR_0 = SetTexcoord4();
			Output O_RT0 = new OutputFLOAT4("COLOR0");

			//S_TEX = SetTexture(s_tex, LINEAR_MIP_LINEAR, CLAMP, CLAMP, TRUE); //tekstura nie ma mipmap i sie jebie na ps4
			S_TEX = SetTexture(s_tex, LINEAR_NO_MIP, CLAMP, CLAMP, TRUE);

			vec3_dat clr = pow(v_color * f_intensity, 2.2);
			C_COLOR = SetConst(clr, 0.0);

			if(extent_on)
			{
                Define("D_EXTENT_ON", 1);
                C_EXTENT = SetConst(v_extent.x, v_extent.y, v_extent.z);
				Input I_UV_1 = new InputFloat2("TEXCOORD1");
				Input I_CLR_0 = new InputFloat4("COLOR0");
				if(fade_angle_on)
				{
					Input I_NRM_MS = new InputFloat3("NORMAL0");
				}
			}
			else
			{
				Input I_POS_MS = new InputFloat4("POSITION");
			}

			if(glow_1_on)
			{
				Define("D_GLOW_ON", 1);
			}

			if(fade_angle_on)
			{
				float_dat f_fade_angle_scale = If(f_fade_angle_max != f_fade_angle_min, 1.0 / (f_fade_angle_max - f_fade_angle_min), f_fade_angle_max);
                Define("D_FADE_ANGLE_MUL_ON", 1);
                C_FADE_ANGLE_MUL = SetConst(f_fade_angle_scale);
                C_FADE_ANGLE_ADD = SetConst(-f_fade_angle_min * f_fade_angle_scale);
			}

			if(f_offset_scale > 0.0)
			{
                Define("D_OFFSET_SCALE_ON", 1);
                C_OFFSET_SCALE = SetConst(f_offset_scale);
			}

			if(b_sun_on)
			{
				extern float_dat f_pp_sky_distance;
				C_SCALE_SKY = SetConst(f_pp_sky_distance);
			}
			if(b_sun_on | b_depth_test_on)
			{
				use PP_DEPTH4_TMU();
			}

			if(b_depth_test_on)
			{
				Define("DEPTH_TEST_ON", 1);

				if(!b_sun_on)
				{
					X_DPT = SetTexcoord();
				}
                C_DEPTH_BIAS = SetConst(f_dpt_bias);
			}

			if(b_sun_on | !b_glow_on)
			{
				X_UV_CENTER = SetTexcoord2();
			}
			if(b_glow_on)
			{
				Define("GLOW_ON", 1);
                C_DPT_OFFSET = SetConst(-f_size_scale);
                C_SIZE_SCALE_GLOW = SetConst(f_size_scale);
				if(fade_angle_on)
				{
					X_FADE_ANGLE = SetTexcoord();
				}
			}
			else
			{
				float_dat f_fade_screen_scale = If(f_fade_screen_max != f_fade_screen_min, 1.0 / (f_fade_screen_max - f_fade_screen_min), f_fade_screen_max);
                C_FADE_SCREEN_MUL = SetConst(-f_fade_screen_scale);
                C_FADE_SCREEN_ADD = SetConst(1.0 + f_fade_screen_min * f_fade_screen_scale);

				extern vec4_dat RT_PARAMS;
				extern float_dat f_screen_aspect_ratio_x_factor;
				C_SIZE_SCALE = SetConst(f_size_scale * RT_PARAMS.x / RT_PARAMS.y * f_screen_aspect_ratio_x_factor, f_size_scale);
			}

			if(b_sun_on)
			{
				Define("SUN_ON", 1);

				extern vec3_dat CAMERA_POS_WS;
				extern vec3_dat v_pp_sun_face_dir;
				extern float_dat f_pp_sky_distance;

				vec4_dat v_pos_sun_ws = vec(CAMERA_POS_WS + v_pp_sun_face_dir * f_pp_sky_distance, 1.0);
				C_POS_SUN_WS = SetConst(v_pos_sun_ws);

				S_CLOUDS = SetTexture(i_um_clouds_msk, LINEAR_NO_MIP, CLAMP, CLAMP, FALSE);

				C_HALF_SCALE_SKY = SetConst(-f_pp_sky_distance * 0.5);
			}
			else
			{
				Input I_CLR_USR = new InputFloat4("COLOR_USER");
			}

			if(f_fade_far_max > f_fade_far_min)
			{
				float_dat f_fade_far_scale = If(f_fade_far_max != f_fade_far_min, 1.0 / (f_fade_far_max - f_fade_far_min), f_fade_far_max);
                Define("D_FADE_FAR_MUL_ON", 1);
                C_FADE_FAR_MUL = SetConst(-f_fade_far_scale);
                C_FADE_FAR_ADD = SetConst(1.0 + f_fade_far_min * f_fade_far_scale);

			}

			if(f_fade_near_max > f_fade_near_min)
			{
				float_dat f_fade_near_scale = If(f_fade_near_max != f_fade_near_min, 1.0 / (f_fade_near_max - f_fade_near_min), f_fade_near_max);
                Define("D_FADE_NEAR_MUL_ON", 1);
                C_FADE_NEAR_MUL = SetConst(f_fade_near_scale);
                C_FADE_NEAR_ADD = SetConst(-f_fade_near_min * f_fade_near_scale);
			}

			VertexShader()
			{
				use Instancing();
				hlsl()
				{
					#include <master_new.hlsl>

					void main()
					{
						X_UV_0 = Decode_UV(I_UV_0);

						float4 v_pos_ws = float4(1.0, 1.0, 1.0, 1.0);
                        #if defined(D_EXTENT_ON)
							float4 pos_ms = I_CLR_0 * float2(2.0, 0.0).xxxy + float2(-1.0, 1.0).xxxy;
                            pos_ms.xyz *= C_EXTENT;
							v_pos_ws = Mul_Pos(pos_ms, MODEL_XFORM_4x3);

							float2 offset_xy = Decode_UV(I_UV_1);

                            #if defined(D_FADE_ANGLE_MUL_ON)
								float3 nrm_ms = I_NRM_MS;
							#endif
                            #if defined(D_OFFSET_SCALE_ON)
                                float offset_mask = (I_CLR_0.w * C_OFFSET_SCALE) + (C_OFFSET_SCALE - 1.0) * -0.5;
							#endif
						#else
							float4 pos_ms = Decode_Pos(I_POS_MS);

							float2 offset_xy = pos_ms.xy;

                            #if defined(D_FADE_ANGLE_MUL_ON)
								float3 nrm_ms = float3(0.0, 0.0, 1.0);
							#endif
                            #if defined(D_OFFSET_SCALE_ON)
                                float offset_mask = pos_ms.z * C_OFFSET_SCALE;
							#endif

							#if defined(SUN_ON)
								v_pos_ws = C_POS_SUN_WS;
							#else
								v_pos_ws.x = MODEL_XFORM_4x3[0].w;
								v_pos_ws.y = MODEL_XFORM_4x3[1].w;
								v_pos_ws.z = MODEL_XFORM_4x3[2].w;
							#endif
						#endif

						float f_fade = 1.0;

                        #if defined(D_FADE_ANGLE_MUL_ON) || defined(D_FADE_FAR_MUL_ON) || defined(D_FADE_NEAR_MUL_ON)
							float3 v_cam_dir_ws = CAMERA_POS_WS.xyz - v_pos_ws.xyz;
                            #if defined(D_FADE_ANGLE_MUL_ON)
								float3 v_cam_dir_n_ws = normalize(v_cam_dir_ws);
								float3 nrm_ws = Mul33(nrm_ms, MODEL_XFORM_4x3);
								float f_angle_fade = dot(nrm_ws, v_cam_dir_n_ws);
                                f_angle_fade = saturate(f_angle_fade * C_FADE_ANGLE_MUL + C_FADE_ANGLE_ADD);
								#if defined(GLOW_ON) && defined(X_FADE_ANGLE)
                                    X_FADE_ANGLE = f_angle_fade * C_DPT_OFFSET;
								#else
									f_fade *= f_angle_fade;
								#endif
							#endif
                            #if defined(D_FADE_FAR_MUL_ON) || defined(D_FADE_NEAR_MUL_ON)
								float f_cam_dir_length = length(v_cam_dir_ws);
                                #if defined(D_FADE_FAR_MUL_ON)
                                    f_fade *= saturate(f_cam_dir_length * C_FADE_FAR_MUL + C_FADE_FAR_ADD);
								#endif
                                #if defined(D_FADE_NEAR_MUL_ON)
                                    f_fade *= saturate(f_cam_dir_length * C_FADE_NEAR_MUL + C_FADE_NEAR_ADD);
								#endif
							#endif
							f_fade *= f_fade;
						#endif

						#if defined(GLOW_ON)
							float4 v_pos_cs = Mul_Pos(v_pos_ws, VIEW_XFORM);

                            v_pos_cs.xy += offset_xy * C_SIZE_SCALE_GLOW * f_fade;

							float4 v_pos_ss = Pos_Out_CS(v_pos_cs);
						#else
							float4 v_pos_ss = Pos_Out_WS(v_pos_ws);

							v_pos_ss.z = 0.5 * v_pos_ss.w;

							float2 v_pos_ss_n = v_pos_ss.xy / v_pos_ss.w;

                            f_fade *= saturate(max(abs(v_pos_ss_n.x), abs(v_pos_ss_n.y)) * C_FADE_SCREEN_MUL + C_FADE_SCREEN_ADD);

							X_UV_CENTER = v_pos_ss_n * float2(0.5, -0.5) + 0.5;

                            #if defined(D_OFFSET_SCALE_ON)
								v_pos_ss.xy = lerp(v_pos_ss.xy, -v_pos_ss.xy, offset_mask);
							#endif

							v_pos_ss.xy += offset_xy * C_SIZE_SCALE * f_fade * v_pos_ss.w;
						#endif

						if(f_fade <= 0.0) v_pos_ss = float4(0.0, 0.0, -1.0, 1.0);

						V_POS_OUT_TC = v_pos_ss;

						#if defined(D_EMS_ON) & defined(DEPTH_TEST_ON)
							float3 v_pivot_pos_ws = float3(MODEL_XFORM_4x3[0].w, MODEL_XFORM_4x3[1].w, MODEL_XFORM_4x3[2].w);
							float4 pos_ss = Pos_Out_WS(float4(v_pivot_pos_ws,1));
							V_POS_OUT_TC.z = pos_ss.z;
						#endif

						X_CLR_0 = C_COLOR * SwizzleXXXX(f_fade);

						#if !defined(SUN_ON)
							X_CLR_0.xyz *= pow(Decode_Usr(I_CLR_USR).xyz, SwizzleXXX(2.2));
							#if defined(DEPTH_TEST_ON)
                                X_DPT = v_pos_ss.w + C_DEPTH_BIAS;
							#endif
						#endif

					}
				}
			}

			PixelShader()
			{
				hlsl()
				{
					#include <master_new.hlsl>

					void main()
					{
						O_RT0 = X_CLR_0;

						O_RT0.xyz *= Sample_h3(S_TEX, X_UV_0);

						#if defined(SUN_ON)
							FLOAT clouds_mask = Sample_h1(S_CLOUDS, X_UV_CENTER, 0.0);
							O_RT0.xyz *= clouds_mask;
						#endif

						#if defined(DEPTH_TEST_ON) & !defined(D_EMS_ON)
							#if defined(SUN_ON)
								FLOAT f_dpt = C_HALF_SCALE_SKY;
							#else
								FLOAT f_dpt = X_DPT;
							#endif
							#if defined(GLOW_ON)
								FLOAT2 v_uv = UV_Screen(V_POS_SS_TC);
								#if defined(X_FADE_ANGLE)
									f_dpt += X_FADE_ANGLE;
								#endif
							#else
								FLOAT2 v_uv = X_UV_CENTER;
							#endif

							FLOAT2 dpt_4 = Depth4_Weights_Sample(v_uv);
							FLOAT dpt_mask = saturate(f_dpt * dpt_4.x + dpt_4.y);
							O_RT0 = O_RT0 - O_RT0 * SwizzleXXXX(dpt_mask); //O_RT0 *= 1.0 - dpt_mask;
						#endif
					}
				}
			}
        }
    }
}
