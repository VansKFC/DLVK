ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 0.500000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.100000)
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
		keyv4(0.207213, 1.000539, 1.000539, 1.000539, -1.000000)
		keyv4(0.214356, 1.000000, 1.000000, 1.000000, 0.999306)
		keyv4(0.700889, 1.000000, 1.000000, 1.000000, 0.999993)
	}

	Size()
	{
		randf(0.120995, 0.061368, 0.100000)
		randf(0.280104, 0.019426, 0.041343)
		keyf(0.500000, 0.000000)
	}

	Align("always")

	AspectRatio()
	{
		keyf(-0.010476, 0.314731)
		keyf(0.797492, 0.367556)
		keyf(0.997325, 0.500000)
	}

	Material("bloodsplash_a.mat", "bloodsplash_a.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

