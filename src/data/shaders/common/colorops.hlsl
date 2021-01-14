#if !defined(COLOROPS_INCLUDED)
    FLOAT Saturation(FLOAT3 v_clr)
    {
        FLOAT f_min = min(min(v_clr.r, v_clr.g), v_clr.b); //    x = Math.min(Math.min(red, grn), blu);
        FLOAT f_max = max(max(v_clr.r, v_clr.g), v_clr.b); //    val = Math.max(Math.max(red, grn), blu);
        return (f_max-f_min)/f_max;
    }

    FLOAT Luminance(FLOAT3 v_clr, FLOAT3 v_weights) { return dot(v_weights, v_clr.xyz); }
    FLOAT Luminance(FLOAT3 v_clr) { return Luminance(v_clr.xyz, FLOAT3(0.2125, 0.7154, 0.0721)); }
    FLOAT Luminance_Equal(FLOAT3 v_clr) { return Luminance(v_clr.xyz, FLOAT3(1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0)); }



	FLOAT3 Desaturate(FLOAT3 v_clr, FLOAT f_desaturation)
	{
		FLOAT f_lum = Luminance(v_clr);
		FLOAT3 v_out = FLOAT3(lerp(v_clr, FLOAT3(f_lum, f_lum, f_lum), f_desaturation));
		return v_out;
	}

    FLOAT3 Overlay(FLOAT3 v_clr_a, FLOAT3 v_clr_b)
    {
		return v_clr_a + v_clr_b - v_clr_a * v_clr_b; //1-(1-A)*(1-B)
    }    

	FLOAT3 YUV2RGB(FLOAT f_y, FLOAT f_u, FLOAT f_v)
	{
		FLOAT3 v_rgb = float3(1.164, 1.164, 1.164) * (f_y - 0.0625);
		
		v_rgb.gb += FLOAT2(-0.391, 2.018) * (f_u - 0.5);
		v_rgb.rg += FLOAT2(1.596, -0.813) * (f_v - 0.5); 

		v_rgb.r = 1.164 * ( f_y - 0.0625 ) + 1.596 * ( f_v - 0.5 );
		v_rgb.g = 1.164 * ( f_y - 0.0625 ) - 0.391 * ( f_u - 0.5 ) - 0.813 * ( f_v - 0.5 );
		v_rgb.b = 1.164 * ( f_y - 0.0625 ) + 2.018 * ( f_u - 0.5 );		
		
		return v_rgb;
	}	
	
	
	

	FLOAT3 YUV2RGB(FLOAT3 v_yuv)	{ return YUV2RGB(v_yuv.x, v_yuv.y, v_yuv.z); }
	
	
	
    float3 RGB2HSB(float3 v_rgb)
    {

        float3 v_hsb;//    var x, val, f, i, hue, sat, val;
//    red/=255;
//    grn/=255;
//    blu/=255;

        float f_min = min(min(v_rgb.r, v_rgb.g), v_rgb.b); //    x = Math.min(Math.min(red, grn), blu);
        float f_max = max(max(v_rgb.r, v_rgb.g), v_rgb.b); //    val = Math.max(Math.max(red, grn), blu);

        float f = (v_rgb.g == f_min) ? v_rgb.b - v_rgb.r : v_rgb.r - v_rgb.g; // f = (red == x) ? grn-blu : ((grn == x) ? blu-red : red-grn);
        f = (v_rgb.r == f_min ) ? v_rgb.g - v_rgb.b : f;

        float i = (v_rgb.g == f_min) ? 5.0 : 1.0; //    i = (red == x) ? 3 : ((grn == x) ? 5 : 1);
        i = (v_rgb.r == f_min) ? 3.0 : i; //    i = (red == x) ? 3 : ((grn == x) ? 5 : 1);        

        v_hsb.x = mod(floor((i-f/(f_max-f_min))*60.0), 360.0); //    hue = Math.floor((i-f/(val-x))*60)%360;                       
                
        v_hsb.y = floor(((f_max-f_min)/f_max)*100.0); //    sat = Math.floor(((val-x)/val)*100);
        v_hsb.z = floor(f_max * 100.0);//val = Math.floor(val*100);

        if(f_min == f_max) v_hsb = float3(0.0, 0.0, f_max * 100.0); // if (x==val){ return({h:undefined, s:0, v:val*100});}

        return v_hsb; //return({h:hue, s:sat, v:val});
    }
    
    
    
    

    float3 HSB2RGB(float3 v_hsb) 
    {
        float3 v_rgb = float3(0.0, 0.0, 0.0);        
        
        //v_hsb.x  = (v_hsb.x % 360.0); 
        //v_hsb.x  %= 360.0;         
        //v_hsb.x = mod(v_hsb.x,  360.0);
        
        modquick(v_hsb.x,  360.0);
        v_hsb /= float3(60.0, 100.0, 100.0);
                                           
                                            
        float i = floor(v_hsb.x); //i = Math.floor(hue);
        float f = v_hsb.x - i; //f = hue-i;
        float p = v_hsb.z * (1.0 - v_hsb.y);//p = val*(1-sat);
        float q = v_hsb.z * (1.0 - (v_hsb.y * f));//q = val*(1-(sat*f));
        float t = v_hsb.z * (1.0 - (v_hsb.y * (1.0 - f)));//t = val*(1-(sat*(1-f)));
        if(i==0) v_rgb = float3(v_hsb.z, t, p);//if (i==0) {red=val; grn=t; blu=p;}
        if(i==1) v_rgb = float3(q, v_hsb.z, p);//else if (i==1) {red=q; grn=val; blu=p;}
        if(i==2) v_rgb = float3(p, v_hsb.z, t);//else if (i==2) {red=p; grn=val; blu=t;}
        if(i==3) v_rgb = float3(p, q, v_hsb.z);//else if (i==3) {red=p; grn=q; blu=val;}
        if(i==4) v_rgb = float3(t, p, v_hsb.z);//else if (i==4) {red=t; grn=p; blu=val;}
        if(i==5) v_rgb = float3(v_hsb.z, p, q); //else if (i==5) {red=val; grn=p; blu=q;}

//        red = Math.floor(red*255);
//        grn = Math.floor(grn*255);
//        blu = Math.floor(blu*255);

        if(v_hsb.z == 0.0) v_rgb = float3(0.0, 0.0, 0.0); //if(val==0) {return({r:0, g:0, v:0});}

        return v_rgb; //return ({r:red, g:grn, b:blu});
    }


    FLOAT3 ClrEnv(FLOAT3 v_srf, FLOAT3 v_env)
    {
        FLOAT f_srf_lum = dot(v_srf, FLOAT3(1.0/3.0, 1.0/3.0, 1.0/3.0 ));

        FLOAT3 v_srf_sat = abs(v_srf - FLOAT3(f_srf_lum, f_srf_lum, f_srf_lum));
        FLOAT f_srf_sat = FLOAT(saturate(dot(v_srf_sat, float3(4.0, 4.0, 4.0))));

        FLOAT f_env_lum = dot(v_env, FLOAT3(1.0/3.0, 1.0/3.0, 1.0/3.0 ));

        v_env = FLOAT3(lerp(v_env, FLOAT3(f_env_lum, f_env_lum, f_env_lum), FLOAT3(f_srf_sat, f_srf_sat, f_srf_sat)));
        return v_env * v_env;
    }


    FLOAT4 Mul2Inv(FLOAT4 v_clr)
    {
        FLOAT4 v_clr_inv = float4(1.0, 1.0, 1.0, 1.0) - v_clr;
        return float4(1.0, 1.0, 1.0, 1.0) - v_clr_inv * v_clr_inv;
    }


    FLOAT3 Mul2Inv(FLOAT3 v_clr) { return Mul2Inv(v_clr.xyzz).xyz; }
    FLOAT2 Mul2Inv(FLOAT2 v_clr) { return Mul2Inv(v_clr.xyyy).xy; }
    FLOAT Mul2Inv(FLOAT v_clr) { return Mul2Inv(FLOAT4(v_clr, v_clr, v_clr, v_clr)).x; }


    FLOAT3 Dye(FLOAT3 v_clr, FLOAT3 v_dye)
    {

        FLOAT f_max_dif = (max(max(v_dye.r, v_dye.g), v_dye.b) - min(min(v_dye.r, v_dye.g), v_dye.b));
		
		FLOAT3 v_max_dif = FLOAT3(f_max_dif, f_max_dif, f_max_dif);

        FLOAT3 v_dif = v_clr * v_max_dif * 2.0 - v_max_dif;

        FLOAT3 v_clr_dye = v_dye + v_dif;

        return v_clr_dye;
    }
    
    

    FLOAT3 DyeLum(FLOAT3 v_clr, FLOAT3 v_dye)
    {
        FLOAT f_dye_lum = Luminance(v_dye);
        f_dye_lum = Mul2Inv(f_dye_lum);
        f_dye_lum = Mul2Inv(f_dye_lum);
        return v_clr * f_dye_lum;
    }

    FLOAT3 DyeTerrain(FLOAT3 v_clr, FLOAT3 v_dye, FLOAT f_clr_msk, FLOAT f_dye_map)
    {
        FLOAT3 v_clr_dye_lum = DyeLum(v_clr, v_dye);
        FLOAT3 v_clr_dye = Dye(v_clr, v_dye);
        FLOAT f_msk = FLOAT(saturate(2.0 * f_dye_map - f_clr_msk));//(1.0 - f_det_msk) + (2.0 * v_clr_lod.w - 1.0) = -4 instruction

        return FLOAT3(saturate(lerp(v_clr_dye_lum, v_clr_dye, f_msk)));
    }
    



    FLOAT3 DyeTerrainGlobal(FLOAT3 v_clr, FLOAT3 v_dye, FLOAT f_clr_global_msk)
    {
        FLOAT3 v_clr_dye_lum = DyeLum(v_clr, v_dye);
        FLOAT3 v_clr_dye = Dye(v_clr, v_dye);
        return FLOAT3(saturate(lerp(v_clr_dye_lum, v_clr_dye, f_clr_global_msk)));
    }    

    

    #define COLOROPS_INCLUDED 1    
    
    

#endif

