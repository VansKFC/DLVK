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
		keyf(-0.007847, 69.959274)
		keyf(0.492153, 69.959274)
		keyf(1.500000, 0.000000)
	}

	StartVelocity()
	{
		keyf(0.000000, 185.000000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 75.000000, 99.000000, 75.000000)
	}

	FromEmiterVelocity()
	{
		keyf(0.000000, 0.000000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 0.000000, -1.000000)
	}

}

