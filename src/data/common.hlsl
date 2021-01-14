#if !defined(COMMON_INCLUDED)

	#include <Defines.hlsl>
	#include <CommonVarsLayout.hlsl>


    #if defined(I_REGCOUNT)
		#if (I_REGCOUNT == 2)
			#pragma regcount 2
		#elif (I_REGCOUNT == 3)
			#pragma regcount 3
		#elif (I_REGCOUNT == 4)
			#pragma regcount 4
		#elif (I_REGCOUNT == 5)
			#pragma regcount 5
		#elif (I_REGCOUNT == 6)
			#pragma regcount 6
		#elif (I_REGCOUNT == 7)
			#pragma regcount 7
		#elif (I_REGCOUNT == 8)
			#pragma regcount 8
		#elif (I_REGCOUNT == 9)
			#pragma regcount 9
		#elif (I_REGCOUNT == 10)
			#pragma regcount 10
		#elif (I_REGCOUNT == 11)
			#pragma regcount 11
		#elif (I_REGCOUNT == 12)
			#pragma regcount 12
		#elif (I_REGCOUNT == 13)
			#pragma regcount 13
		#elif (I_REGCOUNT == 14)
			#pragma regcount 14
		#elif (I_REGCOUNT == 15)
			#pragma regcount 15
		#elif (I_REGCOUNT == 16)
			#pragma regcount 16
		#elif (I_REGCOUNT == 17)
			#pragma regcount 17
		#elif (I_REGCOUNT == 18)
			#pragma regcount 18
		#elif (I_REGCOUNT == 19)
			#pragma regcount 19
		#elif (I_REGCOUNT == 20)
			#pragma regcount 20
		#elif (I_REGCOUNT == 21)
			#pragma regcount 21
		#elif (I_REGCOUNT == 22)
			#pragma regcount 22
		#elif (I_REGCOUNT == 23)
			#pragma regcount 23
		#elif (I_REGCOUNT == 24)
			#pragma regcount 24
		#elif (I_REGCOUNT == 25)
			#pragma regcount 25
		#elif (I_REGCOUNT == 26)
			#pragma regcount 26
		#elif (I_REGCOUNT == 27)
			#pragma regcount 27
		#elif (I_REGCOUNT == 28)
			#pragma regcount 28
		#elif (I_REGCOUNT == 29)
			#pragma regcount 29
		#elif (I_REGCOUNT == 30)
			#pragma regcount 30
		#elif (I_REGCOUNT == 31)
			#pragma regcount 31
		#elif (I_REGCOUNT == 32)
			#pragma regcount 32
		#elif (I_REGCOUNT == 33)
			#pragma regcount 33
		#elif (I_REGCOUNT == 34)
			#pragma regcount 34
		#elif (I_REGCOUNT == 35)
			#pragma regcount 35
		#elif (I_REGCOUNT == 36)
			#pragma regcount 36
		#elif (I_REGCOUNT == 37)
			#pragma regcount 37
		#elif (I_REGCOUNT == 38)
			#pragma regcount 38
		#elif (I_REGCOUNT == 39)
			#pragma regcount 39
		#elif (I_REGCOUNT == 40)
			#pragma regcount 40
		#elif (I_REGCOUNT == 41)
			#pragma regcount 41
		#elif (I_REGCOUNT == 42)
			#pragma regcount 42
		#elif (I_REGCOUNT == 43)
			#pragma regcount 43
		#elif (I_REGCOUNT == 44)
			#pragma regcount 44
		#elif (I_REGCOUNT == 45)
			#pragma regcount 45
		#elif (I_REGCOUNT == 46)
			#pragma regcount 46
		#elif (I_REGCOUNT == 47)
			#pragma regcount 47
		#elif (I_REGCOUNT == 48)
			#pragma regcount 48
    #endif
	#endif


    CONST_FLOAT4 CONST_0;//user color 0
    CONST_FLOAT4 CONST_1;//user color 1

    FLOAT ScreenMask(FLOAT4 v_pos_ss)
    {
		FLOAT2 v_odd = FLOAT2(frac(v_pos_ss.xy * 0.5));
        return abs(v_odd.x - v_odd.y);
    }


    #if !defined(CST_AUTO_OFF)
        #if defined(CST_000)
            #if !defined(CST_000_TYPE)
                #define CST_000_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_000_MTX)
                CST_000_TYPE CST_000[4];
            #else
                CST_000_TYPE CST_000;
            #endif
        #endif
        #if defined(CST_001)
            #if !defined(CST_001_TYPE)
                #define CST_001_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_001_MTX)
                CST_001_TYPE CST_001[4];
            #else
                CST_001_TYPE CST_001;
            #endif
        #endif
        #if defined(CST_002)
            #if !defined(CST_002_TYPE)
                #define CST_002_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_002_MTX)
                CST_002_TYPE CST_002[4];
            #else
                CST_002_TYPE CST_002;
            #endif
        #endif
        #if defined(CST_003)
            #if !defined(CST_003_TYPE)
                #define CST_003_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_003_MTX)
                CST_003_TYPE CST_003[4];
            #else
                CST_003_TYPE CST_003;
            #endif
        #endif
        #if defined(CST_004)
            #if !defined(CST_004_TYPE)
                #define CST_004_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_004_MTX)
                CST_004_TYPE CST_004[4];
            #else
                CST_004_TYPE CST_004;
            #endif
        #endif
        #if defined(CST_005)
            #if !defined(CST_005_TYPE)
                #define CST_005_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_005_MTX)
                CST_005_TYPE CST_005[4];
            #else
                CST_005_TYPE CST_005;
            #endif
        #endif
        #if defined(CST_006)
            #if !defined(CST_006_TYPE)
                #define CST_006_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_006_MTX)
                CST_006_TYPE CST_006[4];
            #else
                CST_006_TYPE CST_006;
            #endif
        #endif
        #if defined(CST_007)
            #if !defined(CST_007_TYPE)
                #define CST_007_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_007_MTX)
                CST_007_TYPE CST_007[4];
            #else
                CST_007_TYPE CST_007;
            #endif
        #endif
        #if defined(CST_008)
            #if !defined(CST_008_TYPE)
                #define CST_008_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_008_MTX)
                CST_008_TYPE CST_008[4];
            #else
                CST_008_TYPE CST_008;
            #endif
        #endif
        #if defined(CST_009)
            #if !defined(CST_009_TYPE)
                #define CST_009_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_009_MTX)
                CST_009_TYPE CST_009[4];
            #else
                CST_009_TYPE CST_009;
            #endif
        #endif
        #if defined(CST_010)
            #if !defined(CST_010_TYPE)
                #define CST_010_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_010_MTX)
                CST_010_TYPE CST_010[4];
            #else
                CST_010_TYPE CST_010;
            #endif
        #endif
        #if defined(CST_011)
            #if !defined(CST_011_TYPE)
                #define CST_011_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_011_MTX)
                CST_011_TYPE CST_011[4];
            #else
                CST_011_TYPE CST_011;
            #endif
        #endif
        #if defined(CST_012)
            #if !defined(CST_012_TYPE)
                #define CST_012_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_012_MTX)
                CST_012_TYPE CST_012[4];
            #else
                CST_012_TYPE CST_012;
            #endif
        #endif
        #if defined(CST_013)
            #if !defined(CST_013_TYPE)
                #define CST_013_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_013_MTX)
                CST_013_TYPE CST_013[4];
            #else
                CST_013_TYPE CST_013;
            #endif
        #endif
        #if defined(CST_014)
            #if !defined(CST_014_TYPE)
                #define CST_014_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_014_MTX)
                CST_014_TYPE CST_014[4];
            #else
                CST_014_TYPE CST_014;
            #endif
        #endif
        #if defined(CST_015)
            #if !defined(CST_015_TYPE)
                #define CST_015_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_015_MTX)
                CST_015_TYPE CST_015[4];
            #else
                CST_015_TYPE CST_015;
            #endif
        #endif
        #if defined(CST_016)
            #if !defined(CST_016_TYPE)
                #define CST_016_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_016_MTX)
                CST_016_TYPE CST_016[4];
            #else
                CST_016_TYPE CST_016;
            #endif
        #endif
        #if defined(CST_017)
            #if !defined(CST_017_TYPE)
                #define CST_017_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_017_MTX)
                CST_017_TYPE CST_017[4];
            #else
                CST_017_TYPE CST_017;
            #endif
        #endif
        #if defined(CST_018)
            #if !defined(CST_018_TYPE)
                #define CST_018_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_018_MTX)
                CST_018_TYPE CST_018[4];
            #else
                CST_018_TYPE CST_018;
            #endif
        #endif
        #if defined(CST_019)
            #if !defined(CST_019_TYPE)
                #define CST_019_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_019_MTX)
                CST_019_TYPE CST_019[4];
            #else
                CST_019_TYPE CST_019;
            #endif
        #endif
        #if defined(CST_020)
            #if !defined(CST_020_TYPE)
                #define CST_020_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_020_MTX)
                CST_020_TYPE CST_020[4];
            #else
                CST_020_TYPE CST_020;
            #endif
        #endif
        #if defined(CST_021)
            #if !defined(CST_021_TYPE)
                #define CST_021_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_021_MTX)
                CST_021_TYPE CST_021[4];
            #else
                CST_021_TYPE CST_021;
            #endif
        #endif
        #if defined(CST_022)
            #if !defined(CST_022_TYPE)
                #define CST_022_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_022_MTX)
                CST_022_TYPE CST_022[4];
            #else
                CST_022_TYPE CST_022;
            #endif
        #endif
        #if defined(CST_023)
            #if !defined(CST_023_TYPE)
                #define CST_023_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_023_MTX)
                CST_023_TYPE CST_023[4];
            #else
                CST_023_TYPE CST_023;
            #endif
        #endif
        #if defined(CST_024)
            #if !defined(CST_024_TYPE)
                #define CST_024_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_024_MTX)
                CST_024_TYPE CST_024[4];
            #else
                CST_024_TYPE CST_024;
            #endif
        #endif
        #if defined(CST_025)
            #if !defined(CST_025_TYPE)
                #define CST_025_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_025_MTX)
                CST_025_TYPE CST_025[4];
            #else
                CST_025_TYPE CST_025;
            #endif
        #endif
        #if defined(CST_026)
            #if !defined(CST_026_TYPE)
                #define CST_026_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_026_MTX)
                CST_026_TYPE CST_026[4];
            #else
                CST_026_TYPE CST_026;
            #endif
        #endif
        #if defined(CST_027)
            #if !defined(CST_027_TYPE)
                #define CST_027_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_027_MTX)
                CST_027_TYPE CST_027[4];
            #else
                CST_027_TYPE CST_027;
            #endif
        #endif
        #if defined(CST_028)
            #if !defined(CST_028_TYPE)
                #define CST_028_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_028_MTX)
                CST_028_TYPE CST_028[4];
            #else
                CST_028_TYPE CST_028;
            #endif
        #endif
        #if defined(CST_029)
            #if !defined(CST_029_TYPE)
                #define CST_029_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_029_MTX)
                CST_029_TYPE CST_029[4];
            #else
                CST_029_TYPE CST_029;
            #endif
        #endif
        #if defined(CST_030)
            #if !defined(CST_030_TYPE)
                #define CST_030_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_030_MTX)
                CST_030_TYPE CST_030[4];
            #else
                CST_030_TYPE CST_030;
            #endif
        #endif
        #if defined(CST_031)
            #if !defined(CST_031_TYPE)
                #define CST_031_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_031_MTX)
                CST_031_TYPE CST_031[4];
            #else
                CST_031_TYPE CST_031;
            #endif
        #endif

		#if defined(CST_032)
            #if !defined(CST_032_TYPE)
                #define CST_032_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_032_MTX)
                CST_032_TYPE CST_032[4];
            #else
                CST_032_TYPE CST_032;
            #endif
        #endif

		#if defined(CST_033)
            #if !defined(CST_033_TYPE)
                #define CST_033_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_033_MTX)
                CST_033_TYPE CST_033[4];
            #else
                CST_033_TYPE CST_033;
            #endif
        #endif

		#if defined(CST_034)
            #if !defined(CST_034_TYPE)
                #define CST_034_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_034_MTX)
                CST_034_TYPE CST_034[4];
            #else
                CST_034_TYPE CST_034;
            #endif
        #endif

		#if defined(CST_035)
            #if !defined(CST_035_TYPE)
                #define CST_035_TYPE CONST_FLOAT4
            #endif
            #if defined(CST_035_MTX)
                CST_035_TYPE CST_035[4];
            #else
                CST_035_TYPE CST_035;
            #endif
        #endif
    #endif



	CONST_FLOAT4 FRUSTUM_PARAMS;
	CONST_FLOAT4 DISTANCE_FADE;

    CONST_FLOAT4 v_level_dye_color;
    CONST_FLOAT4 v_terrain_uv_scaleoffset;
    CONST_FLOAT3 vSunDir;

    #if defined(SHADER_PATH_PS3)
        #define INV_FRUSTUM_0 INV_FRUSTUM0
        #define INV_FRUSTUM_1 INV_FRUSTUM1
    #else
        #define INV_FRUSTUM_0 INV_FRUSTUM[0]
        #define INV_FRUSTUM_1 INV_FRUSTUM[1]
    #endif

    CONST_FLOAT3 main_view_camera_pos;

	#include <mtx.hlsl>


    float dsl_NearZ(float f_z) { return min(-FRUSTUM_PARAMS.x - 0.01, f_z); } // 'min' because .z values are negative, -21 is a negative near clipping plane with a little offset (1)


    #if defined(CST_DIR_UP)
        CONST_FLOAT4 CST_DIR_UP;
    #endif
    #if defined(CST_OCL_SCALES)
        CONST_FLOAT4 CST_OCL_SCALES;
    #endif

    #if !defined(LINEARSTEP)
        #define LINEARSTEP (vValue-vMin)/(vMax-vMin)
        #if defined(HALF_ON)
            //HALF
            FLOAT linearstep(FLOAT vMin, FLOAT vMax, FLOAT vValue) { return LINEARSTEP; }
            FLOAT2 linearstep(FLOAT2 vMin, FLOAT2 vMax, FLOAT2 vValue) { return LINEARSTEP; }
            FLOAT3 linearstep(FLOAT3 vMin, FLOAT3 vMax, FLOAT3 vValue) { return LINEARSTEP; }
            FLOAT4 linearstep(FLOAT4 vMin, FLOAT4 vMax, FLOAT4 vValue) { return LINEARSTEP; }
        #endif
        //FLOAT
        float linearstep(float vMin, float vMax, float vValue) { return LINEARSTEP; }
        float2 linearstep(float2 vMin, float2 vMax, float2 vValue) { return LINEARSTEP; }
        float3 linearstep(float3 vMin, float3 vMax, float3 vValue) { return LINEARSTEP; }
        float4 linearstep(float4 vMin, float4 vMax, float4 vValue) { return LINEARSTEP; }
    #endif



    #if defined(FADE)
        CONST_FLOAT4 CST_FADE_0;
        CONST_FLOAT4 CST_FADE_1;
        CONST_FLOAT4 CST_FADE_2;

        struct FADE_STRUCT
        {
            FLOAT2 FADE_FIELD_0;
            FLOAT2 FADE_FIELD_1;
            FLOAT2 FADE_FIELD_2;
        };

        FADE_STRUCT SetFade(float3 v_cam_dir)
        {
            FADE_STRUCT FADE;

            v_cam_dir /= FLOAT16_DEPTH_SCALE;
            FLOAT f_distance = dot(v_cam_dir, v_cam_dir);

            FADE.FADE_FIELD_0 = saturate(f_distance * F_FADE_0_MUL + F_FADE_0_ADD);
            FADE.FADE_FIELD_1 = saturate(f_distance * F_FADE_1_MUL + F_FADE_1_ADD);
            FADE.FADE_FIELD_2 = saturate(f_distance * F_FADE_2_MUL + F_FADE_2_ADD);

            return FADE;
        }
    #endif

	FLOAT4 Gamma_Decode(FLOAT4 v_clr) { return FLOAT4(pow(v_clr, float4(2.2, 2.2, 2.2, 2.2))); }

    FLOAT3 Gamma_Decode(FLOAT3 v_clr) { return FLOAT3(pow(v_clr, float3(2.2, 2.2, 2.2))); }
	FLOAT Gamma_Decode(FLOAT f_clr) { return FLOAT(pow(f_clr, 2.2)); }

		FLOAT3 Gamma_Encode(FLOAT3 v_clr) { return FLOAT3(pow(v_clr, float3(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2))); }
    FLOAT4 Gamma_Encode(FLOAT4 v_clr) { return FLOAT4(pow(v_clr, float4(1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2, 1.0 / 2.2))); }



    #define F_RANGE 255.0
    #define V_FLOAT8x4_BITSHIFTS float4(F_RANGE*F_RANGE*F_RANGE, F_RANGE*F_RANGE, F_RANGE, 1.0)

	#include <sample.hlsl>

	#if defined(VERTEXSHADER) || defined(HULLSHADER) || defined(DOMAINSHADER) || defined(COMPUTESHADER)
	    #include <common_vs.hlsl>
	#endif

	#if defined(PIXELSHADER) || defined(HULLSHADER) || defined(DOMAINSHADER) || defined(COMPUTESHADER)
		#include <common_ps.hlsl>
	#endif

	CONST_FLOAT4 GAMMA;

    FLOAT3 Gamma_Win_Decode(FLOAT3 v_clr)
    {
        return FLOAT3(pow(v_clr, GAMMA.xxx));
    }

    FLOAT3 Gamma_Win_Encode(FLOAT3 v_clr)
    {
        return FLOAT3(pow(v_clr, GAMMA.yyy));
	}

    #define COMMON_INCLUDED 1

#endif