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
		keyf(0.000000, 0.800000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 0.000000, 0.000000, 0.000000)
	}

	Position()
	{
		keyv(0.000000, 0.020000, 0.000000, 0.000000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 1.000000, 0.000000)
	}

	AlphaFadeOut("worst", 2, 1)
	AlphaFadeOut("best", 2, 1)
}

