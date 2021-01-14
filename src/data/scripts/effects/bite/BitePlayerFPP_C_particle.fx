ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 0.500000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.000000)
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
		keyv4(0.000000, 1.000000, 1.000000, 1.000000, 0.000000)
		keyv4(0.165532, 0.988079, 0.988079, 0.988079, 0.995964)
		keyv4(0.500000, 1.000000, 1.000000, 1.000000, 0.000000)
	}

	Size()
	{
		keyf(-0.000833, 0.021481)
		randf(0.692061, 0.038856, 0.052372)
	}

	Material("bloodspray_a.mat", "bloodspray_a.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

