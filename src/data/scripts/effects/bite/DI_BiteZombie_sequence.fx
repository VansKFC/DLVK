SequenceDef()
{
	Meter()

	Color()
	{
		keyv4(0.000000, 0.588235, 0.588235, 0.588235, 1.000000)
	}

	Repeat(1)

	TurnOffDistance()
	{
		keyf(0.000000, 49.000000)
	}

	Delay(1.000000)

	Spawn()
	{
		ParticleEmiter("Bite_BloodFromMouth_B_emiter.fx", "Bite_BloodFromMouth_B_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("Bite_BloodFromMouth_A_emiter.fx", "Bite_BloodFromMouth_A_particle.fx")
	}

}

