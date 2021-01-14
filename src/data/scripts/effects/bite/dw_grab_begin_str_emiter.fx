EmiterDef()
{
	Meter()

	Space("world")

	GenType("continous")

	GenArea("point")

	LifeTime()
	{
		keyf(0.000000, 0.000000)
	}

	ParticleRate()
	{
		keyf(0.000000, 10.000000)
		keyf(3.000000, 0.000000)
	}

	StartVelocity()
	{
		keyf(0.000000, 1.300000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 0.200000, 0.700000, 0.200000)
	}

	Position()
	{
		keyv(0.000000, 0.000000, 0.000000, 0.000000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 1.000000, 0.000000)
	}

}

