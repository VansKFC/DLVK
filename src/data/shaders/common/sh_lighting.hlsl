// constants containing irradiance environment map
#define cAr 0
#define cAg 1
#define cAb 2
#define cBr 3
#define cBg 4
#define cBb 5
#define cC  6

float3 ShadeIrad(float4 sh_coeffs[7], float3 normal) 
{
	float3 x1, x2, x3;

	float4 vNormal = float4(normal, 1.0f);

	// Linear + constant polynomial terms
	x1.r = dot(sh_coeffs[cAr], vNormal);
	x1.g = dot(sh_coeffs[cAg], vNormal);
	x1.b = dot(sh_coeffs[cAb], vNormal);

	// 4 of the quadratic polynomials
	float4 vB = vNormal.xyzz * vNormal.yzzx; 
	x2.r = dot(sh_coeffs[cBr], vB);
	x2.g = dot(sh_coeffs[cBg], vB);
	x2.b = dot(sh_coeffs[cBb], vB);

	// Final quadratic polynomial
	float vC = vNormal.x*vNormal.x - vNormal.y*vNormal.y;
	x3 = sh_coeffs[cC].rgb * vC; 

	return x1 + x2 + x3;
	//return float3(sh_coeffs[0].w, sh_coeffs[1].w, sh_coeffs[2].w);
}
/*
Texture3D t_Ar; SamplerState s_Ar;
Texture3D t_Ag; SamplerState s_Ag;
Texture3D t_Ab; SamplerState s_Ab;
Texture3D t_Br; SamplerState s_Br;
Texture3D t_Bg; SamplerState s_Bg;
Texture3D t_Bb; SamplerState s_Bb;
Texture3D t_C;  SamplerState s_C;

Texture3D t_ZMap0;  SamplerState s_ZMap0;
Texture3D t_ZMap1;  SamplerState s_ZMap1;

#define LIGHTPROBES_ARRAY_XFORM CONST_150
float4 LIGHTPROBES_ARRAY_XFORM[3];

void SampleSHCoeffs(float3 pos_ws, out float4 sh_coeffs[7])
{
	float4 pos = float4(pos_ws, 1.0f);

	float3 uvw;
	uvw.x = dot(pos, LIGHTPROBES_ARRAY_XFORM[0]);
	uvw.y = dot(pos, LIGHTPROBES_ARRAY_XFORM[1]);
	uvw.z = dot(pos, LIGHTPROBES_ARRAY_XFORM[2]);

	uvw = uvw*0.5 + 0.5;

	sh_coeffs[cAr] = t_Ar.Sample(s_Ar, uvw);
	sh_coeffs[cAg] = t_Ag.Sample(s_Ag, uvw);
	sh_coeffs[cAb] = t_Ab.Sample(s_Ab, uvw);
	sh_coeffs[cBr] = t_Br.Sample(s_Br, uvw);
	sh_coeffs[cBg] = t_Bg.Sample(s_Bg, uvw);
	sh_coeffs[cBb] = t_Bb.Sample(s_Bb, uvw);
	sh_coeffs[cC ] = t_C.Sample(s_C, uvw);
}

void Load3D(Texture3D t, int4 uvwm, out float4 samples[8])
{
    samples[0] = t.Load(uvwm, int3(0, 0, 0));
    samples[1] = t.Load(uvwm, int3(1, 0, 0));
    samples[2] = t.Load(uvwm, int3(0, 1, 0));
    samples[3] = t.Load(uvwm, int3(1, 1, 0));
    samples[4] = t.Load(uvwm, int3(0, 0, 1));
    samples[5] = t.Load(uvwm, int3(1, 0, 1));
    samples[6] = t.Load(uvwm, int3(0, 1, 1));
    samples[7] = t.Load(uvwm, int3(1, 1, 1));
}

void Sample3D(Texture3D t, SamplerState s, float3 uvw, out float4 samples[8])
{
    samples[0] = t.Sample(s, uvw, int3(0, 0, 0));
    samples[1] = t.Sample(s, uvw, int3(1, 0, 0));
    samples[2] = t.Sample(s, uvw, int3(0, 1, 0));
    samples[3] = t.Sample(s, uvw, int3(1, 1, 0));
    samples[4] = t.Sample(s, uvw, int3(0, 0, 1));
    samples[5] = t.Sample(s, uvw, int3(1, 0, 1));
    samples[6] = t.Sample(s, uvw, int3(0, 1, 1));
    samples[7] = t.Sample(s, uvw, int3(1, 1, 1));
}

void PrepareFilter3D(out float weights[8], float3 w)
{
    float3 omw = 1 - w;

    weights[0] = omw.x * omw.y * omw.z;
    weights[1] =   w.x * omw.y * omw.z;
    weights[2] = omw.x *   w.y * omw.z;
    weights[3] =   w.x *   w.y * omw.z;
    weights[4] = omw.x * omw.y *   w.z;
    weights[5] =   w.x * omw.y *   w.z;
    weights[6] = omw.x *   w.y *   w.z;
    weights[7] =   w.x *   w.y *   w.z;
}

float PrepareFilter3DScale(float weights[8])
{
    return 1.0f / (
        weights[0] +
        weights[1] +
        weights[2] +
        weights[3] +
        weights[4] +
        weights[5] +
        weights[6] +
        weights[7]);
}

float4 Filter3D(float4 samples[8], float weights[8], float scale)
{
    float4 sum = 
        samples[0] * weights[0] + 
        samples[1] * weights[1] + 
        samples[2] * weights[2] + 
        samples[3] * weights[3] + 
        samples[4] * weights[4] + 
        samples[5] * weights[5] + 
        samples[6] * weights[6] + 
        samples[7] * weights[7];

    return sum * scale;
}

float sum(float a, float b)
{
    return a + b - a*b;
}

float Occlusion(float3 pos, float4 zmap_xz, float4 zmap_y)
{
    // zmap: +x -x +z -z

    zmap_xz *= 1.05;
    zmap_y *= 1.05;

    float3 to_point = pos;

    float occ = 1.0f;

    if ( to_point.x > zmap_xz.x) occ = 0;
    if (-to_point.x > zmap_xz.y) occ = 0;
    if ( to_point.z > zmap_xz.z) occ = 0;
    if (-to_point.z > zmap_xz.w) occ = 0;
    
    if ( to_point.y > zmap_y.x) occ = 0;
    if (-to_point.y > zmap_y.y) occ = 0;

    //return sum(zmap.y, to_point.x*0.2 + 0.2);
    //return to_point.x;
    return occ;
}

void SampleSHCoeffs2(float3 pos_ws, out float4 sh_coeffs[7])
{
	float4 pos = float4(pos_ws, 1.0f);

	float3 uvw;
	uvw.x = dot(pos, LIGHTPROBES_ARRAY_XFORM[0]);
	uvw.y = dot(pos, LIGHTPROBES_ARRAY_XFORM[1]);
	uvw.z = dot(pos, LIGHTPROBES_ARRAY_XFORM[2]);

	uvw = uvw*0.5 + 0.5;

    float3 dim;
    t_Ar.GetDimensions(dim.x, dim.y, dim.z);
    uvw *= dim;

    int4 uvwm;
    uvwm.xyz = floor(uvw - 0.5);
    uvwm.w = 0;

    float4 sh_coeffs_temp[7][8];

	Load3D(t_Ar, uvwm, sh_coeffs_temp[cAr]);
	Load3D(t_Ag, uvwm, sh_coeffs_temp[cAg]);
	Load3D(t_Ab, uvwm, sh_coeffs_temp[cAb]);
	Load3D(t_Br, uvwm, sh_coeffs_temp[cBr]);
	Load3D(t_Bg, uvwm, sh_coeffs_temp[cBg]);
	Load3D(t_Bb, uvwm, sh_coeffs_temp[cBb]);
	Load3D(t_C , uvwm, sh_coeffs_temp[cC ]);

    float4 zmap[2][8];
	Load3D(t_ZMap0, uvwm, zmap[0]);
	Load3D(t_ZMap1, uvwm, zmap[1]);

    float weights[8];
    PrepareFilter3D(weights, frac(uvw - 0.5));

    const float3 probe_pos[8] = { 
        float3(0,0,0),
        float3(1,0,0),
        float3(0,1,0),
        float3(1,1,0),
        float3(0,0,1),
        float3(1,0,1),
        float3(0,1,1),
        float3(1,1,1) };

    for (int i = 0; i < 8; ++i)
        weights[i] *= Occlusion(frac(uvw - 0.5) - probe_pos[i], zmap[0][i], zmap[1][i]);

    float scale = PrepareFilter3DScale(weights);

    for (int i = 0; i < 7; ++i)
        //sh_coeffs[i] = sh_coeffs_temp[i][0];
        sh_coeffs[i] = Filter3D(sh_coeffs_temp[i], weights, scale);

    //sh_coeffs[0] = zmap[0][0];

    //sh_coeffs[0] = t_ZMap0.Sample(s_ZMap0, uvw);
}

float3 ShadeIrad(float3 pos_ws, float3 normal_ws) 
{
	float4 sh_coeffs[7];
	SampleSHCoeffs2(pos_ws, sh_coeffs);
	return ShadeIrad(sh_coeffs, normal_ws);
    //return sh_coeffs[0];
}
*/
