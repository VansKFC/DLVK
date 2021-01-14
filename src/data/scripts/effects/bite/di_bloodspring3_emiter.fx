EmiterDef()
{
	Meter()

	Space("world")

	GenType("one_time")

	GenArea("point")

	LifeTime()
	{
		keyf(0.000000, 1.000000)
	}

	NumParticles()
	{
		keyf(0.000000, 16.000000)
	}

	StartVelocity()
	{
		keyf(-0.017277, 9.013283)
		keyf(0.979533, 5.550000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 2.110000, 5.550000, 2.110000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 1.000000, 0.000000)
	}

	TurnOffDistance()
	{
		keyf(0.000000, 49.000000)
	}

}

