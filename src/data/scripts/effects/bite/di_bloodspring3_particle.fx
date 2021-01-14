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
		keyf(0.000000, 8.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 1.000000)
	}

	Color()
	{
		keyv4(0.000574, 0.716366, 0.716366, 0.716366, 0.987808)
		keyv4(0.508351, 0.720652, 0.716730, 0.716730, 0.990944)
		keyv4(0.997648, 0.724209, 0.724209, 0.720287, 0.984239)
	}

	Size()
	{
		randf(-0.000729, 0.276423, 0.533572)
		randf(0.202857, 0.067031, 0.128897)
		keyf(0.700414, 0.002529)
	}

	Align("always")

	AspectRatio()
	{
		keyf(-0.000253, 1.049303)
		keyf(0.506697, 2.030009)
	}

	Material("di_bloodbig_particleblend.mat", "di_bloodbig_particleblend.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

