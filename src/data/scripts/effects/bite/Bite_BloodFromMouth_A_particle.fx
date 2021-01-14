ParticleDef()
{
	Meter()

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
		keyf(0.000000, 0.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(0.100000, 0.156863, 0.000000, 0.000000, 0.999306)
		keyv4(0.500000, 0.156863, 0.000000, 0.000000, 0.000000)
	}

	Size()
	{
		keyf(0.000000, 0.020000)
		keyf(1.000000, 0.100000)
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

