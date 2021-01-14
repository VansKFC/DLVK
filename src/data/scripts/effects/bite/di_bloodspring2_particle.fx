ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 0.700000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.300000)
	}

	Drag()
	{
		keyf(0.000000, 4.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 1.000000)
	}

	Color()
	{
		keyv4(0.099030, 0.759006, 0.747241, 0.759006, 1.000388)
		keyv4(0.345070, 0.745849, 0.745849, 0.745849, 0.236136)
		keyv4(0.699047, 0.699916, 0.707759, 0.711681, -0.005640)
	}

	Size()
	{
		randf(-0.000141, 0.185774, 0.418733)
		randf(0.699738, 0.345870, 0.562304)
	}

	Rotation()
	{
		randf(-0.001693, 0.299278, 101.018723)
		randf(0.998307, 0.299278, 101.018723)
	}

	Material("di_bloodspray_particleblend.mat", "di_bloodspray_particleblend.mat")

	TexMultiRect(2, 1, 2)

	TexPlayMode("random_once", 1.000000)

}

