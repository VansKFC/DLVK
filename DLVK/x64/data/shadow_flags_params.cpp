//Reduce shadow intensity for cleaner load
sub main(){
shadow_area_limit_0(-1.0);
shadow_area_limit_1(0.4 * 0.4 * 1);
/*Remove unneeded math.
ray_distance(0);
max_rays_count(0);*/
mesh("slums_pipeline_a"){
num_shadows(1,1);
inc_shadows();}
mesh("slums_pipeline_a_*"){alias("slums_pipeline_a");}
mesh("slums_pipeline_stand_a") {alias("slums_pipeline_a");}
mesh("slums_pipeline_bend_a_*"){alias("slums_pipeline_a");}
mesh("fence_wire_a"){
num_shadows(1,1);}
mesh("fence_wire_gate_?"){alias("fence_wire_a");}
mesh("fence_wire_panel_?"){alias("fence_wire_a");}
mesh("fence_wire_panel_?_des"){alias("fence_wire_a");}
mesh("tracks_traction"){
num_shadows(1,1);
inc_shadows();}
mesh("wall_str_*lod");
mesh("wall_str_*"){
inc_shadows();}
mesh("walls_and_roofs"){
num_shadows(1,1);
inc_shadows();}
mesh("kiosk_round_a"){alias("walls_and_roofs");}
mesh("wall_cor_03_log_ot_a"){alias("walls_and_roofs");}
mesh("roof_cor_0303_ot_f"){alias("walls_and_roofs");}
mesh("roof_cor_0303_ot_s"){alias("walls_and_roofs");}
mesh("roof_str_0303_ot_s_end"){alias("walls_and_roofs");}
mesh("atrium_l1_cor"){alias("walls_and_roofs");}
mesh("umbrella_fabric_big_b"){alias("walls_and_roofs");}
mesh("dlc_house_wall_a_40cm"){alias("walls_and_roofs");}
mesh("dlc_house_wall_a_80cm"){alias("walls_and_roofs");}
mesh("dlc_house_wall_a_corner"){alias("walls_and_roofs");}
mesh("dlc_house_wall_a_corner_b"){alias("walls_and_roofs");}
mesh("dlc_house_attic_a"){alias("walls_and_roofs");}
mesh("dlc_house_attic_a_40cm"){alias("walls_and_roofs");}
mesh("dlc_house_attic_a_corner_a"){alias("walls_and_roofs");}
mesh("dlc_house_attic_a_corner_b"){alias("walls_and_roofs");}
mesh("dlc_house_attic_a_corner_c"){alias("walls_and_roofs");}
mesh("dlc_house_attic_a_end"){alias("walls_and_roofs");}
mesh("dlc_house_attic_a_hole_a"){ alias("walls_and_roofs");}
mesh("ot_attic_a"){ alias("walls_and_roofs");}
mesh("wall_str_0601_a"){ alias("walls_and_roofs");}
mesh("ts_dome_a"){ alias("walls_and_roofs");}
mesh("ts_dome_a_metal"){ alias("walls_and_roofs");}
mesh("ts_dome_top"){ alias("walls_and_roofs");}    
mesh("wl_traffic_sign_?"){
num_shadows(1,1);
inc_shadows();}
mesh("street_stand_b"){
num_shadows(1,1);
inc_shadows();}
mesh("dlc_road_barricade"){alias("street_stand_b");}
mesh("dlc_wl_traffic_cone_a"){alias("street_stand_b");}
mesh("dlc_highway_barrier_?"){
num_shadows(1,1);
inc_shadows();}
mesh("thuja_a"){
num_shadows(1,-1);}}
