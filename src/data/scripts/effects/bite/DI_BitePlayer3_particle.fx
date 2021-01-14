ParticleDef()
{
	LifeTime()
	{
		keyf(0.000000, 0.500000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.300000)
	}

	Drag()
	{
		keyf(0.000000, 2.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(0.000329, 0.791963, 0.791993, 0.791963, 0.999944)
		keyv4(1.005289, 0.791528, 0.791438, 0.791707, 1.000351)
	}

	Size()
	{
		randf(-0.000733, 5.695375, 10.247005)
		randf(0.180421, 1.292669, 2.270092)
		keyf(0.501067, -0.052738)
	}

	Align("always")

	AspectRatio()
	{
		keyf(0.000000, 0.985201)
		keyf(1.000000, 2.057348)
	}

	Material("di_bloodsmall_particleblend.mat", "di_bloodsmall_particleblend.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

