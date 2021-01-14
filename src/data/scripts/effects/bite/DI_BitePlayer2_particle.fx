ParticleDef()
{
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
		keyv4(-0.000071, 0.797010, 0.796944, 0.797010, 0.999306)
		keyv4(0.700889, 0.797076, 0.796790, 0.796944, 0.999993)
	}

	Size()
	{
		randf(-0.000103, 4.865498, 10.031518)
		randf(0.216148, 1.388657, 2.630630)
		keyf(0.500304, -0.044706)
	}

	Align("always")

	AspectRatio()
	{
		keyf(0.000000, 0.988823)
		keyf(0.997325, 1.983158)
	}

	Material("di_bloodsmall_particleblend.mat", "di_bloodsmall_particleblend.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

