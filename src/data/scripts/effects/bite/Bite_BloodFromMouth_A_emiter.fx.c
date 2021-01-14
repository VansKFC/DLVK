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
		keyf(0.000371, 50.658669)
		keyf(2.000000, 0.000000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 0.100000, 0.100000, 0.100000)
	}

	FromEmiterVelocity()
	{
		keyf(0.000000, 0.003000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 0.000000, -1.000000)
	}

 TurnOffDistance()
 {
	keyf(0.000000, 49.000000)
 }
return 0;  
}
