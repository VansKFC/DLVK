//VARLIST PARAMS /////////////////////////
uniform float3 v_wind_omni_pos;
uniform float f_wind_omni_power;
uniform float f_wind_omni_range;
uniform float3 v_wind_force;
uniform float f_wind_speed;
uniform float f_wind_phase_factor;
uniform float f_wind_sway_range;
uniform float4 v_wind_wave_length;
uniform float f_wind_wave_center;

CONST_FLOAT4 v_pp_wind_params_0;
CONST_FLOAT4 v_pp_wind_params_1;
CONST_FLOAT4 v_pp_wind_params_2;
CONST_FLOAT4 v_pp_wind_params_3;

//INPUT PARAMS /////////////////////
//CONST 0
//XYZ:
#define V_WIND_FORCE v_wind_force
//W:
#define F_WIND_PHASE_FACTOR f_wind_phase_factor

//CONST 1
//X:
#define F_WIND_WAVE_CENTER v_pp_wind_params_1.x
//Y:
#define F_WIND_WAVE_CENTER_INV v_pp_wind_params_1.y
//Z:
#define F_WIND_OMNI_WEIGHT_SCALE v_pp_wind_params_3.w
//W:
#define F_WIND_OMNI_WEIGHT_BIAS 1.0

//CONST 2
//XYZ:
#define V_WIND_POS v_wind_omni_pos
//W:
#define F_WIND_OMNI_POWER v_pp_wind_params_2.z;

//CONST 3
//X:  //bend range + *2-1
#define F_WIND_POWER_SCALE v_pp_wind_params_1.z
//Y:  //bend range + *2-1
#define F_WIND_POWER_BIAS  v_pp_wind_params_1.w
//Z:
#define F_WIND_PHASE_SHIFT_SCALE 1.0
//W:
#define F_WIND_PHASE v_pp_wind_params_2.x

//CONST 4
#define V_WIND_WAVE_LENGTH_INV v_pp_wind_params_0

#define V_WIND_POS_BIAS v_pp_wind_params_3.xyz

float GetWindDir_Phase(float3 v_obj_pos, float f_phase_shift) { return f_phase_shift + F_WIND_PHASE + dot(v_obj_pos, FLOAT3(F_WIND_PHASE_FACTOR, F_WIND_PHASE_FACTOR, F_WIND_PHASE_FACTOR)); }
float3 GetWindDir_Force(float f_power) { return V_WIND_FORCE * f_power; }


float GetWindDir_Power(float f_phase)
{
    float4 v_phases = f_phase * V_WIND_WAVE_LENGTH_INV;

    float4 v_x = frac(v_phases);

    float4 v_power = min(v_x * F_WIND_WAVE_CENTER, F_WIND_WAVE_CENTER_INV - F_WIND_WAVE_CENTER_INV * v_x);
    v_power = smoothstep(0.0, 1.0, v_power);

    float f_power = dot(v_power, float4(0.25, 0.25, 0.25, 0.25));

    return f_power * F_WIND_POWER_SCALE + F_WIND_POWER_BIAS;
}



float GetWindDir_Power(float3 v_obj_pos, float f_phase_shift)
{
    float f_phase = GetWindDir_Phase(v_obj_pos, f_phase_shift);
    
    return GetWindDir_Power(f_phase);
}

float3 GetWindDir(float3 v_obj_pos, float f_phase_shift)
{//directional
    float f_power = GetWindDir_Power(v_obj_pos, f_phase_shift);

    return GetWindDir_Force(f_power);
}



float3 GetWindOmni(float3 v_vrt_pos)
{//omni
    float3 v_vrt_dir = v_vrt_pos * F_WIND_OMNI_WEIGHT_SCALE + V_WIND_POS_BIAS;
    float f_distance = saturate(dot(v_vrt_dir, v_vrt_dir));

    float f_power = F_WIND_OMNI_POWER - f_distance * F_WIND_OMNI_POWER;

    float3 v_dir_n = normalize(v_vrt_dir);

    return v_dir_n * f_power;
}


float3 GetWind(float3 v_obj_pos, float f_phase_shift, float3 v_vrt_pos)
{
    return GetWindDir(v_obj_pos, f_phase_shift) + GetWindOmni(v_vrt_pos);
}

//OLD WIND ////////////////////////////////////////////
uniform float4 grass_wind_force_params;
uniform float4 grass_wave;
uniform float4 grass_wind_force;
uniform float4 grass_params;
#if defined(WIND_PARAMS_0)
    float4 WIND_PARAMS_0;
#endif

float4 SmoothCurve(float4 v_x)
{
    return v_x * v_x * (3.0 - 2.0 * v_x);
}

float4 TriangleWave(float4 v_x)
{
    return abs(frac(v_x + 0.5) * 2.0 - 1.0);
}

float4 SmoothTriangleWave(float4 v_x)
{
    return SmoothCurve(TriangleWave(v_x));
}


//#define WINDWAVES_TRI_ON 1
float4 WindWaves(float3 v_pos, float f_phase_shift)
{
    float f_phase_obj = dot(v_pos, float3(1.0, 1.0, 1.0)) + f_phase_shift;
    float4 v_frequencies = float4(1.975, 0.793, 0.375, 0.193);
//    float4 v_frequencies = {1, 1, 4, 4};
    float4 v_phase_obj = f_phase_obj * v_frequencies;

    #if defined(WINDWAVES_TRI_ON)
        return SmoothTriangleWave((frac(TIME + v_phase_obj)) * 2.0 - 1.0);
    #else
        return grass_wind_force_params * sin(grass_wave * 2.0 + v_phase_obj);
    #endif
}

float WindPower(float4 v_wind_waves)
{
    return dot(v_wind_waves, float4(1.0, 1.0, 1.0, 1.0));
}


float WindPower(float3 v_pos, float f_phase_shift)
{
    float4 v_wind_waves = WindWaves(v_pos, f_phase_shift);
    return WindPower(v_wind_waves);
}

float2 WindForce(float f_wind_power)
{
    return grass_wind_force.xy * f_wind_power + grass_wind_force.zw;
}

float2 WindForce(float3 v_pos, float f_phase_shift)
{
    float f_wind_power = WindPower(v_pos, f_phase_shift);
    return WindForce(f_wind_power);
}

