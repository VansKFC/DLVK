ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 0.500000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.300000)
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
		keyv4(0.000000, 0.313726, 0.000000, 0.000000, 1.000000)
		keyv4(0.048095, 0.313726, 0.000000, 0.000000, 0.740534)
		keyv4(0.401000, 0.313726, 0.000000, 0.000000, -0.003943)
	}

	Size()
	{
		keyf(-0.002266, 0.013750)
		randf(0.681319, 0.120000, 0.170000)
	}

	Rotation()
	{
		randf(0.000000, 0.000000, 360.000000)
	}

	DataAtTexcoord1("particle_rotation")

	Material("particleblood.mat", "particleblood.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

