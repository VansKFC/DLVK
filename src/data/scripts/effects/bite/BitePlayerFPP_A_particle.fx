ParticleDef()
{
	Meter()

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
		keyv4(0.135770, 1.007885, 1.007885, 1.007885, 1.007885)
		keyv4(0.500000, 1.000000, 1.000000, 1.000000, 0.000000)
	}

	Size()
	{
		randf(0.099867, 0.018952, 0.040721)
		randf(0.175992, 0.015566, 0.027996)
		keyf(0.318696, -0.000324)
	}

	Align("on_start")

	AlignEndToOrigin()

	AspectRatio()
	{
		keyf(0.001048, 0.376631)
		keyf(1.000000, 1.000000)
	}

	Material("bloodsplash_a.mat", "bloodsplash_a.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

