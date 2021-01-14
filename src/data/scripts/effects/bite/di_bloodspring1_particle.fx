ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 1.000000)
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
		keyf(0.000000, 1.000000)
	}

	Color()
	{
		keyv4(0.002277, 0.687813, 0.687813, 0.687813, 0.994760)
		keyv4(0.518573, 0.696097, 0.692175, 0.692175, 0.940695)
		keyv4(0.999351, 0.700662, 0.700662, 0.696740, 0.744343)
	}

	Size()
	{
		randf(-0.000872, 0.196025, 0.293098)
		randf(0.201026, 0.076586, 0.122195)
		randf(0.587451, 0.016147, 0.023842)
		keyf(0.999967, -0.000036)
	}

	Align("on_start")

	AspectRatio()
	{
		keyf(-0.000751, 0.282078)
		keyf(0.477506, 3.075709)
	}

	Material("di_bloodsmall_particleblend.mat", "di_bloodsmall_particleblend.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

}

