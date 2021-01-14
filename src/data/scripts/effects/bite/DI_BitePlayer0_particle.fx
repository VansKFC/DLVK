ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 1.000000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.100000)
	}

	Drag()
	{
		keyf(0.000000, 1.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(-0.000386, 0.803231, 0.806064, 0.807153, 0.999306)
		keyv4(0.201159, 0.807501, 0.807501, 0.807501, 0.553446)
		keyv4(0.999589, 0.780392, 0.780392, 0.792157, -0.007533)
	}

	Size()
	{
		randf(0.000228, 0.048362, 0.073599)
		randf(1.001058, 0.122537, 0.294834)
	}

	AspectRatio()
	{
		keyf(0.000000, 1.000000)
	}

	Material("di_bloodspray_particleblend.mat", "di_bloodspray_particleblend.mat")

	TexMultiRect(2, 1, 2)

	TexPlayMode("random_once", 1.000000)

}

