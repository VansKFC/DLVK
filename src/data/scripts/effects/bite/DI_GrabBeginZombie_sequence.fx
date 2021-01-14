SequenceDef()
{
	Meter()

	Position()
	{
		keyv(0.000000, 0.000000, 0.000000, 0.000000)
	}

	Repeat(1)

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("dw_grabbegin_blood_emiter.fx", "dw_grabbegin_blood_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("dw_grab_begin_str_emiter.fx", "dw_grab_begin_str_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("dw_grabbegin_part_emiter.fx", "dw_grabbegin_part_particle.fx")
	}

	Delay(0.000000)

	Spawn()
	{
		ParticleEmiter("dw_grabbegin_part4_emiter.fx", "dw_grabbegin_part4_particle.fx")
	}

}

