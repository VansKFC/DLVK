ParticleDef()
{
	Meter()

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
		randf(-0.006002, 0.044060, 0.099982)
		randf(0.541732, 0.013503, 0.025547)
		keyf(2.000950, -0.000284)
	}

	Align("always")

	AspectRatio()
	{
		keyf(0.000000, 1.000000)
	}

	Material("di_bloodsmall_particleblend.mat", "di_bloodsmall_particleblend.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

