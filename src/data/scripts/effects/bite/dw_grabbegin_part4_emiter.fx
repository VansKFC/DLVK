EmiterDef()
{
	Meter()

	Space("world")

	GenType("continous")

	GenArea("point")

	LifeTime()
	{
		keyf(0.000000, 3.000000)
	}

	ParticleRate()
	{
		keyf(-0.000091, -7.667394)
		keyf(0.027447, 101.606628)
		keyf(3.000000, -17.911880)
	}

	StartVelocity()
	{
		keyf(1.520684, 0.700000)
	}

	StartVelocityRand()
	{
		keyv(0.000000, 0.700000, 0.700000, 0.700000)
	}

	Position()
	{
		keyv(0.000000, 0.000000, 0.000000, 0.000000)
	}

	Direction()
	{
		keyv(0.000000, 0.000000, 1.000000, 0.000000)
	}

	AlphaFadeOut("worst", 6, 1)
	AlphaFadeOut("best", 6, 1)
	TurnOffDistance()
	{
		keyf(0.000000, 7.000000)
	}

}

