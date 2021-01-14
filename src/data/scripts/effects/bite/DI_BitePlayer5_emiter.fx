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
		keyf(0.703190, 198.667007)
		keyf(1.487520, -0.478612)
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
		keyf(0.000000, 0.000000)
	}

	Position()
	{
		keyv(0.000000, 2.000000, 0.000000, -12.000000)
		keyv(2.000000, 2.000000, -20.000000, -12.000000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 0.000000, -1.000000)
	}

}

