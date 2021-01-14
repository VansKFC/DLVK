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
		ParticleEmiter("DI_BloodSpring1_emiter.fx", "DI_BloodSpring1_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("DI_BloodSpring2_emiter.fx", "DI_BloodSpring2_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("DI_BloodSpring3_emiter.fx", "DI_BloodSpring3_particle.fx")
	}

}

