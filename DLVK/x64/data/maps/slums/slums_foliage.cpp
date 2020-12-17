 TravelDistance(1.00)
 RayRanges(-100.00, 1000.00)
 Layer("Grass")
 {
    RenderRangesLod(36.00, 0.00, 0.00)
    BlendRangesLod(0, 5.00, 5.00)
    DensityMap("slums_foliage_grass")
    InstancesPerMeter(15.00)
    ExpensiveTraces(1)
    Type()
    {
        MeshLod(0, "foliage_grass_a.msh", "foliage_grass_a_fade.mat")
        Priority(50)
        AlignToNormal(1)
        Scale(0.40, 0.50)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "plant_b_a.msh", "plant_b.mat")
        Priority(2)
        AlignToNormal(1)
        Scale(1.00, 1.00)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_grass_a.msh", "foliage_grass_a_fade.mat")
        Priority(30)
        AlignToNormal(0)
        Scale(0.50, 0.90)
        Shadows(1, 0)
    }
 }
 Layer("Stones")
 {
    RenderRangesLod(20.00, 0.00, 0.00)
    BlendRangesLod(0, 10.00, 10.00)
    DensityMap("slums_foliage_stones")
    InstancesPerMeter(5.40)
    ExpensiveTraces(1)
    Type()
    {
        MeshLod(0, "foliage_trash_stone_c.msh", "foliage_trash_stone_a.mat")
        Priority(2)
        AlignToNormal(1)
        Scale(1.00, 1.30)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_trash_stone_d.msh", "foliage_trash_stone_a.mat")
        Priority(2)
        AlignToNormal(1)
        Scale(1.00, 1.30)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_trash_stone_e.msh", "foliage_trash_stone_a.mat")
        Priority(2)
        AlignToNormal(1)
        Scale(1.00, 1.30)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_trash_stone_f.msh", "foliage_trash_stone_a.mat")
        Priority(2)
        AlignToNormal(1)
        Scale(1.00, 1.30)
        Shadows(-1, 0)
    }
 }
 Layer("Trash")
 {
    RenderRangesLod(15.00, 0.00, 0.00)
    BlendRangesLod(0, 5.00, 5.00)
    DensityMap("slums_foliage_trash")
    InstancesPerMeter(2.50)
    ExpensiveTraces(1)
    Type()
    {
        MeshLod(0, "foliage_paper_a.msh", "paper_foliage.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.10)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_paper_b.msh", "paper_foliage.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.10)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_paper_d.msh", "paper_foliage.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.10)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_trash_a.msh", "trash_foliage.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.10)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_trash_b.msh", "trash_foliage.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.10)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_trash_d.msh", "trash_foliage.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.10)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_trash_bottle_b.msh", "foliage_trash_a.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.10)
        Shadows(-1, 0)
    }
    Type()
    {
        MeshLod(0, "to_carton_box_a.msh", "to_carton_box_a.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.00)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "to_carton_box_b.msh", "to_carton_box_b.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.00)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "to_carton_box_c.msh", "to_carton_box_c.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.00)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_paper_b.msh", "paper_foliage.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.00)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_trash_d.msh", "paper_foliage.mat")
        Priority(5)
        AlignToNormal(1)
        Scale(1.00, 1.00)
        Shadows(1, 0)
    }
 }
 Layer("Nature")
 {
    RenderRangesLod(36.00, 0.00, 0.00)
    BlendRangesLod(0, 5.00, 5.00)
    DensityMap("slums_foliage_Nature")
    InstancesPerMeter(4.00)
    ExpensiveTraces(1)
    Type()
    {
        MeshLod(0, "foliage_plant_a.msh", "foliage_plant_a_fade.mat")
        Priority(10)
        AlignToNormal(1)
        Scale(0.60, 0.90)
        Shadows(0, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_plant_b.msh", "foliage_plant_b_fade.mat")
        Priority(10)
        AlignToNormal(1)
        Scale(0.60, 0.90)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_plant_a.msh", "foliage_plant_a_b_fade.mat")
        Priority(30)
        AlignToNormal(1)
        Scale(0.60, 0.90)
        Shadows(0, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_plant_a.msh", "foliage_plant_a_c_fade.mat")
        Priority(20)
        AlignToNormal(1)
        Scale(0.60, 0.90)
        Shadows(0, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_plant_a.msh", "foliage_plant_a_d_fade.mat")
        Priority(10)
        AlignToNormal(1)
        Scale(0.60, 0.90)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "foliage_plant_a.msh", "foliage_plant_a_e_fade.mat")
        Priority(20)
        AlignToNormal(1)
        Scale(0.60, 0.90)
        Shadows(0, 0)
    }
 }
 Layer("underwater_plants")
 {
    RenderRangesLod(32.00, 0.00, 0.00)
    BlendRangesLod(0, 2.00, 5.00)
    DensityMap("slums_foliage_underwater_plants")
    InstancesPerMeter(1.00)
    ExpensiveTraces(1)
    Type()
    {
        MeshLod(0, "water_vegetation_a.msh", "water_vegetation_a.mat")
        Priority(30)
        AlignToNormal(0)
        Scale(0.40, 1.20)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "water_vegetation_b.msh", "water_vegetation_b.mat")
        Priority(0)
        AlignToNormal(0)
        Scale(0.60, 1.00)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "water_vegetation_c.msh", "water_vegetation_c.mat")
        Priority(0)
        AlignToNormal(0)
        Scale(0.40, 1.30)
        Shadows(1, 0)
    }
 }
 Layer("underwater_plants_b_c")
 {
    RenderRangesLod(32.00, 0.00, 0.00)
    BlendRangesLod(0, 2.00, 5.00)
    DensityMap("slums_foliage_underwater_plants_b_c")
    InstancesPerMeter(1.00)
    ExpensiveTraces(1)
    Type()
    {
        MeshLod(0, "water_vegetation_b.msh", "water_vegetation_b.mat")
        Priority(30)
        AlignToNormal(0)
        Scale(0.30, 1.00)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "water_vegetation_c.msh", "water_vegetation_c.mat")
        Priority(80)
        AlignToNormal(0)
        Scale(0.40, 1.00)
        Shadows(1, 0)
    }
    Type()
    {
        MeshLod(0, "water_vegetation_a.msh", "water_vegetation_a.mat")
        Priority(10)
        AlignToNormal(0)
        Scale(0.10, 1.20)
        Shadows(1, 0)
    }
 }
 Layer("slums_underwater_c")
 {
    RenderRangesLod(32.00, 0.00, 0.00)
    BlendRangesLod(0, 2.00, 5.00)
    DensityMap("slums_foliage_slums_underwater_c")
    InstancesPerMeter(1.00)
    ExpensiveTraces(1)
    Type()
    {
        MeshLod(0, "water_vegetation_c.msh", "water_vegetation_c.mat")
        Priority(100)
        AlignToNormal(0)
        Scale(0.30, 1.00)
        Shadows(1, 0)
    }
 }
 Layer("slums_grass_high_a")
 {
    RenderRangesLod(2.0, 2.0, 2.0)
    BlendRangesLod(0, 2.00, 2.00)
    BlendRangesLod(1, 2.00, 2.00)
    BlendRangesLod(1, 2.00, 2.00)
    DensityMap("slums_foliage_grass_high_a")
    InstancesPerMeter(0.1)
    ExpensiveTraces(0)
    Type()
    {
        MeshLod(0, "particles_128.msh", "grass_b0.mat")
        MeshLod(0, "particles_32.msh", "grass_b1.mat")
        MeshLod(1, "particles_1.msh", "grass_b2.mat")
        Priority(50)
        AlignToNormal(1)
        Scale(1.0,1.0)
        Shadows(0, 0)
    }
 }
 Layer("slums_grass_high_b")
 {
    RenderRangesLod(3.0,4.0,0.0)
    BlendRangesLod(0, 0.0, 0.0)
    BlendRangesLod(1, 0.0, 0.0)
    DensityMap("slums_foliage_grass_high_b")
    InstancesPerMeter(0.1)
    ExpensiveTraces(0)
    Type()
    {
    MeshLod(0, "particles_8.msh", "grass_c0.mat")
    MeshLod(1, "particles_4.msh", "grass_c1.mat")
    Priority(50)
    AlignToNormal(1)
    Scale(1.0, 1.0)
    Shadows(0,0)
 }
}
