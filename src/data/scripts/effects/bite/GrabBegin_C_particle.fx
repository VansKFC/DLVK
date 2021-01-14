ParticleDef()
{
	LifeTime()
	{
		keyf(0.000000, 1.000000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.000000)
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
		keyv4(-0.003905, 1.002688, 1.002688, 1.002688, -0.002688)
		keyv4(0.379238, 1.000000, 1.000000, 1.000000, 0.365233)
		keyv4(1.000000, 1.000000, 1.000000, 1.000000, 0.000000)
	}

	Size()
	{
		keyf(0.000000, 20.000000)
	}

	Material("bloodspray_a.mat", "bloodspray_a.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

