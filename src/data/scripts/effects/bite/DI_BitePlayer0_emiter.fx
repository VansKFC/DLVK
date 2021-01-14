EmiterDef()
{
	Meter()

	Space("world")

	GenType("one_time")

	GenArea("point")

	LifeTime()
	{
		keyf(0.000000, 2.000000)
	}

	NumParticles()
	{
		keyf(0.000000, 20.000000)
	}

	StartVelocity()
	{
		keyf(0.000000, 0.950000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 0.450000, 0.770000, 0.450000)
	}

	FromEmiterVelocity()
	{
		keyf(0.000000, 0.000000)
	}

	Position()
	{
		keyv(0.000000, 0.020000, 0.000000, -0.070000)
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

