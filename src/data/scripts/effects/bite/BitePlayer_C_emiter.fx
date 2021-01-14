EmiterDef()
{
	Space("world")

	GenType("continous")

	GenArea("point")

	LifeTime()
	{
		keyf(0.000000, 5.000000)
	}

	ParticleRate()
	{
		keyf(0.221886, 103.548393)
		keyf(0.600000, 0.000000)
	}

	StartVelocity()
	{
		keyf(0.000000, 200.000000)
		keyf(0.601905, -0.788531)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 30.000000, 100.000000, 30.000000)
		keyv(0.600000, 0.000000, 0.000000, 0.000000)
	}

	Direction()
	{
		keyv(0.000000, 0.500000, 0.250000, -1.000000)
	}

}

