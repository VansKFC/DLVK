SequenceDef()
{
	Meter()

	LifeTime()
	{
		keyf(0.000000, 2.000000)
	}

	Repeat(1)

	TurnOffDistance()
	{
		keyf(0.000000, 49.000000)
	}

	Delay(0.700000)

	Spawn()
	{
		ParticleEmiter("DI_BitePlayer1_emiter.fx", "DI_BitePlayer1_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("DI_BitePlayer0_emiter.fx", "DI_BitePlayer0_particle.fx")
	}

}

