ParticleDef()
{
	Meter()

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
		keyf(0.000000, 0.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(0.202010, 1.000000, 1.000000, 1.000000, 0.486761)
		keyv4(1.000000, 1.000000, 1.000000, 1.000000, 0.000000)
	}

	Size()
	{
		keyf(0.000000, 0.050000)
		keyf(1.000000, 0.200000)
	}

	Rotation()
	{
		randf(0.000000, 0.000000, 360.000000)
	}

	Material("bloodspray_a.mat", "bloodspray_a.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

