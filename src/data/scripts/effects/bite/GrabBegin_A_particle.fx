ParticleDef()
{
	LifeTime()
	{
		keyf(0.000000, 2.000000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.300000)
	}

	Drag()
	{
		keyf(0.000000, 3.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(-0.000386, 0.803231, 0.806064, 0.807153, 0.999306)
		keyv4(1.998330, 0.780392, 0.776073, 0.792157, 0.999993)
	}

	Size()
	{
		randf(-0.006002, 3.299131, 9.998188)
		randf(0.241454, 1.350292, 3.938322)
		keyf(1.000000, -0.028364)
	}

	Align("always")

	AlignEndToOrigin()

	AspectRatio()
	{
		randf(0.000000, 0.200000, 0.300000)
		keyf(0.780145, 0.419739)
		keyf(1.000000, 0.948924)
	}

	Material("bloodsplash_a.mat", "bloodsplash_a.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

