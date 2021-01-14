EmiterDef()
{
	Space("world")

	GenType("continous")

	GenArea("point")

	LifeTime()
	{
		keyf(0.000000, 2.000000)
	}

	ParticleRate()
	{
		keyf(0.800081, 35.048897)
		keyf(1.502764, 34.507813)
	}

	StartVelocity()
	{
		keyf(0.000000, 35.000000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 35.000000, 35.000000, 35.000000)
	}

	FromEmiterVelocity()
	{
		keyf(0.000000, 0.300000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 0.000000, -1.000000)
	}

}

