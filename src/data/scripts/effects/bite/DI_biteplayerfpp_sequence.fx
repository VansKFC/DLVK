SequenceDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 20.000000)
	}

	Position()
	{
		keyv(0.000000, 0.650000, 0.100000, 0.000000)
	}

	Color()
	{
		keyv4(0.000000, 0.498039, 0.498039, 0.498039, 1.000000)
	}

	Repeat(1)

	TurnOffDistance()
	{
		keyf(0.000000, 49.000000)
	}

	Delay(2.500000)

	Spawn()
	{
		Sequence("DI_bitePlayerFpp_Single_sequence.fx")
	}

	Delay(1.500000)

	Spawn()
	{
		Sequence("DI_bitePlayerFpp_Single_sequence.fx")
	}

}

