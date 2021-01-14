ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 3.000000)
	}

	GravityMul()
	{
		randf(0.000000, 0.300000, 0.400000)
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
		keyv4(-0.001070, 0.999741, 0.999741, 0.995820, 0.988707)
		keyv4(0.246036, 0.996078, 0.996078, 0.996078, 0.253666)
		keyv4(0.797762, 1.002822, 1.002822, 1.002822, 0.083802)
	}

	Size()
	{
		keyf(-0.001139, 0.052036)
		keyf(0.241162, 0.152958)
		keyf(0.583743, 0.231594)
		keyf(1.009185, 0.286218)
	}

	Align("on_start")

	AspectRatio()
	{
		keyf(-0.002132, 0.649037)
	}

	DataAtTexcoord1("particle_rotation")

	Material("dw_comp_blood_part4.mat", "dw_comp_blood_part4.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

	TexStartMode("random")
}

