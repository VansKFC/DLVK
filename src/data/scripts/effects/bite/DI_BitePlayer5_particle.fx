ParticleDef()
{
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
		keyf(0.000000, 5.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(-0.000386, 0.803231, 0.806064, 0.807153, 0.999306)
		keyv4(0.702197, 0.780890, 0.782210, 0.790424, 0.999993)
	}

	Size()
	{
		randf(-0.000620, 1.183532, 2.989560)
		keyf(0.499451, -0.030241)
	}

	Align("always")

	AspectRatio()
	{
		keyf(0.000000, 3.000000)
	}

	Material("di_bloodsmall_particleblend.mat", "di_bloodsmall_particleblend.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

