ParticleDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 2.000000)
	}

	GravityMul()
	{
		randf(0.000000, 0.600000, 0.700000)
	}

	Drag()
	{
		randf(0.000000, 0.200000, 0.500000)
	}

	WindInfluence()
	{
		keyf(0.000000, 0.000000)
	}

	Color()
	{
		keyv4(-0.000853, 0.900874, 0.900874, 0.900874, 0.965651)
		keyv4(0.014410, 0.900094, 0.900094, 0.900094, 0.398786)
		keyv4(0.035935, 0.900094, 0.900094, 0.900094, 0.186704)
		keyv4(0.128709, 0.900094, 0.900094, 0.900094, 0.120844)
		keyv4(0.248412, 0.900094, 0.900094, 0.900094, 0.104783)
		keyv4(0.700000, 0.898039, 0.898039, 0.898039, 0.032222)
	}

	Size()
	{
		keyf(-0.001435, 0.107579)
		keyf(0.211889, 0.335743)
		keyf(1.000019, 1.095838)
	}

	Align("on_start")

	AspectRatio()
	{
		randf(0.050000, 0.100000, 0.200000)
		keyf(1.050853, 0.648710)
	}

	DataAtTexcoord1("particle_rotation")

	Material("dw_blood_random_v2.mat", "dw_blood_random_v2.mat")

	TexMultiRect(4, 1, 4)

	TexPlayMode("random_once", 1.000000)

	TexStartMode("random")
}

