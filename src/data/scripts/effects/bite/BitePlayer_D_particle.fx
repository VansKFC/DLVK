ParticleDef()
{
	LifeTime()
	{
		keyf(0.000000, 0.500000)
	}

	GravityMul()
	{
		keyf(0.000000, 0.500000)
	}

	Drag()
	{
		keyf(0.000000, 5.000000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(0.000000, 1.000000, 1.000000, 1.000000, 0.000000)
		keyv4(0.200000, 1.010554, 1.013387, 1.014476, 0.994987)
		keyv4(0.500000, 1.000000, 1.000000, 1.000000, 0.000000)
	}

	Size()
	{
		randf(-0.031620, 0.200000, 0.400000)
	}

	Align("always")

	AspectRatio()
	{
		keyf(0.000000, 1.000000)
	}

	Material("bloodrops_a_alligned.mat", "bloodrops_a_alligned.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

