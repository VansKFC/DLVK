#if !defined(GAMMA_INCLUDED)
	#define GAMMA_VALUE 2.2
	#define GAMMA_VALUE_INV (1.0 / GAMMA_VALUE)
	
	float4 Gamma2Linear(float4 clr)
	{
		return pow(abs(clr), SwizzleXXXX(GAMMA_VALUE)); //abs() - DX11 warning
	}	
		float3 Gamma2Linear(float3 clr)
		{
			return Gamma2Linear(clr.xyzz).xyz;
		}
		float Gamma2Linear(float lum)
		{
			return Gamma2Linear(SwizzleXXXX(lum)).x;
		}

    float4 Linear2Gamma(float4 clr)
	{
		return pow(abs(clr), SwizzleXXXX(GAMMA_VALUE_INV)); //abs() - DX11 warning
	}   
   
		float3 Linear2Gamma(float3 clr)
		{
			return Linear2Gamma(clr.xyzz).xyz;
		}
		float Linear2Gamma(float lum)
		{
			return Linear2Gamma(SwizzleXXXX(lum)).x;
		}
    #define GAMMA_INCLUDED 1       
#endif

