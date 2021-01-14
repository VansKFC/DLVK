EmiterDef()
{
	Meter()

	Space("world")

	GenType("continous")

	GenArea("point")

	LifeTime()
	{
		keyf(0.000000, 2.000000)
	}

	ParticleRate()
	{
		keyf(-0.001723, 269.666199)
		keyf(0.653672, -1.301003)
	}

	StartVelocity()
	{
		keyf(0.000000, 1.000000)
		keyf(1.000000, 0.000000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 0.100000, 0.500000, 0.100000)
		keyv(1.000000, 0.000000, 0.000000, 0.000000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 0.000000, -1.000000)
	}

	TurnOffDistance()
	{
		keyf(0.000000, 49.000000)
	}

}

