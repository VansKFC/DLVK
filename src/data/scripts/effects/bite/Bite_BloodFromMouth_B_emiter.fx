EmiterDef()
{
	Meter()

	Space("world")

	GenType("continous")

	GenArea("point")

	LifeTime()
	{
		keyf(0.000000, 4.000000)
	}

	ParticleRate()
	{
		keyf(-0.003888, 17.104109)
		keyf(2.000000, 0.000000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 0.100000, 0.100000, 0.100000)
	}

	FromEmiterVelocity()
	{
		keyf(0.000000, 0.002000)
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

