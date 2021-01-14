ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 0.500000)
	}

	GravityMul()
	{
		randf(0.000000, 0.400000, 0.600000)
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
		keyv4(0.000335, 0.898039, 0.898039, 0.898039, 0.225892)
		keyv4(0.091830, 0.901961, 0.901961, 0.901961, 0.173270)
		keyv4(0.435126, 0.901961, 0.901961, 0.901961, 0.059515)
	}

	Position()
	{
		keyv(0.000000, 0.000000, 0.000000, 0.000000)
	}

	Size()
	{
		keyf(-0.003880, 0.025853)
		randf(0.244698, 0.102715, 0.124564)
		randf(1.465097, 0.217365, 0.282261)
	}

	Align("on_start")

	AspectRatio()
	{
		keyf(-0.001068, 0.977698)
		keyf(0.999995, 0.463740)
	}

	DataAtTexcoord1("particle_rotation")

	Material("dw_bleeding_4.mat", "dw_bleeding_4.mat")

	TexMultiRect(2, 2, 4)

	TexPlayMode("random_once", 1.000000)

	TexStartMode("random")
}

