ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 0.600000)
	}

	GravityMul()
	{
		randf(0.000000, 0.200000, 0.300000)
	}

	Drag()
	{
		keyf(0.000000, 0.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(-0.002933, 0.911643, 0.911643, 0.911643, 0.242593)
		keyv4(0.601003, 0.913725, 0.913725, 0.913725, 0.050000)
	}

	Size()
	{
		keyf(-0.005400, 0.026841)
		keyf(1.303238, 0.181103)
	}

	Align("on_start")

	AspectRatio()
	{
		keyf(0.000000, 0.677419)
		keyf(1.098680, 1.533588)
	}

	DataAtTexcoord1("particle_rotation")

	Material("dw_comp_blood_part.mat", "dw_comp_blood_part.mat")

}

