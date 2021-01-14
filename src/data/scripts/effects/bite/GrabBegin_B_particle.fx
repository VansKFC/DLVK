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
		keyv4(-0.004032, 0.973078, 0.973078, 0.973078, 0.000000)
		keyv4(0.359764, 1.002648, 1.002648, 1.002648, 1.002648)
		keyv4(0.601334, 1.011696, 1.007377, 1.023461, 0.004035)
	}

	Rotation()
	{
		randf(0.000000, 0.000000, 360.000000)
	}

	Material("bloodsplatbig_a.mat", "bloodsplatbig_a.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

