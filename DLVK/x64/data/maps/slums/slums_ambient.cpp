!include("AmbientSounds.def")
!AmbientVolume(fMasterVolume, fTrack00Volume, fTrack01Volume, fTrack02Volume, fTrack03Volume)
!AmbientSound(sId, sFileName, nTrack, nPriority, nLoops, fVolume, fFadeIn, fFadeOut)


AmbientVolume(1, 1, 1, 1, 1)

AmbientSound( "MSA_Global_Weather",                 "msa_global_weather",                       0, 0900, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Antenna_High_Weather",           "msa_antenna_high_weather",             	0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Antenna_Low_Weather",            "msa_antenna_low_weather",                  0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Antenna_Medium_Weather",         "msa_antenna_medium_weather",               0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Bazar_Weather",                  "msa_bazar_weather",                        0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Bus",                            "msa_van_weather",                       	0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Coastline_Weather",              "msa_coastline_weather",                    0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_FishermenVillage_Weather",       "msa_fisherman_village_weather",            0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Highway_Weather",                "msa_highway_weather",                      0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Jaffar",                         "msa_bazar_weather",                        0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Lake_Weather",                   "msa_coastline_weather",                    0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Market",                         "msa_global_weather",                       0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Van",                            "msa_van_weather",                          0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Zere",                           "msa_zere_weather",                       	0, 1000, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Trainyard_Weather",              "msa_trainyard_weather",                    0, 1100, -1, 1.0,  1,  5  )
AmbientSound( "MSA_SeaSideCity",                    "msa_sea_view_weather",                     0, 1100, -1, 1.0,  5,  2  )
AmbientSound( "MSA_Foliage",                        "msa_global_weather",                       0, 1100, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Tunnel_Weather",                 "msa_tunnel_weather",                       0, 1100, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Wagon",                          "msa_van_weather",                       	0, 1100, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Hill",                           "msa_hill_weather",                    		0, 1100, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Alley",                          "msa_narrow_alley_weather",                 0, 1200, -1, 1.0,  1,  3  )
AmbientSound( "MSA_CauldronAlley",                  "msa_dirty_alley_weather",                  0, 1200, -1, 1.0,  1,  5  )
AmbientSound( "MSA_BridgeShaft_Weather",            "msa_tunnel_weather",            			0, 1200, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Hangar_Weather",                 "msa_hangar_weather",                       0, 1200, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Rooftops",                       "msa_rooftop_weather",               		0, 1300, -1, 0.9,  3,  3  )
AmbientSound( "MSA_Room_Fisherman_Weather",         "msa_room_fisherman_weather",               0, 1400, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Room_Weather",                   "msa_room_weather",                         0, 1400, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Room_Electric_Weather",          "msa_room_weather",                         0, 1400, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Room_Shop_Weather",          	"msa_room_weather",                         0, 1400, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Room_Wooden_Weather",          	"msa_room_weather",                         0, 1400, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Room_Open_Weather",          	"msa_room_weather",                         0, 1400, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Room_Rooftop_Weather",          	"msa_room_weather",                         0, 1400, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Cave_Weather",          			"msa_cave_weather",                         0, 1400, -1, 1.0,  1,  5  )


AmbientSound( "Cave",                               "ambience_wasteland_cave.ogg",              0, 1400, -1, 1.0,  1,  5  )
AmbientSound( "TirLaboratory",                      "ambience_tir_laboratory.ogg",              0, 1100, -1, 1.0,  1,  5  )
AmbientSound( "Interior_Day",                       "msa_room_tower_weather",       			0, 1300, -1, 0.1,  1,  5  )
AmbientSound( "TowerBaseFloor",                     "msa_room_tower_weather", 					0, 1300, -1, 1.0,  1,  5  )
AmbientSound( "Underwater",                         "msa_underwater_weather",           		0, 9999, -1, 1.0,  1,  1  )
AmbientSound( "TowerBaseFloor_Room",                	"ambience_slums_highrise_room.ogg",         0, 1400, -1, 1.0,  1,  3  )
AmbientSound( "Tunnel_ServiceCorridor",                 "msa_tunnel_weather",                       0, 1100, -1, 1.0,  1,  5  )



AmbientSound( "MSA_Safezone",                       "msa_global_weather",                       1, 0100, -1, 1.0,  1,  5  )
AmbientSound( "MSA_Safezone_Interior",              "msa_global_weather",                       1, 0200, -1, 1.0,  1,  5  )

AmbientSound( "WavesJustAboveWaterSurface",         "sea_waves_around_player.ogg",              2, 1000, -1, 1.0,  1,  3  )
AmbientSound( "GasTank_BuildingExplosion",          "explosion_slums_building_st.wav",          2, 2100,  1, 1.0,  0,  40 )

// Track 3 - Additional

AmbientSound( "Wind_Foliage",                       "wind_heavy_leafs_trees_loop.ogg",          3, 1010, -1, 1.0,  4,  4  )

