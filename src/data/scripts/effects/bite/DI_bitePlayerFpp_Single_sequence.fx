SequenceDef()
{
	Meter()

	Repeat(1)

	TurnOffDistance()
	{
		keyf(0.000000, 49.000000)
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("BitePlayerFPP_A_emiter.fx", "BitePlayerFPP_A_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("BitePlayerFPP_B_emiter.fx", "BitePlayerFPP_B_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("BitePlayerFPP_C_emiter.fx", "BitePlayerFPP_C_particle.fx")
	}

}

