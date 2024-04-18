[Mesh]
    [fluid]
        type = GeneratedMeshGenerator
        dim = 3
        nx = 70
        ny = 15
        nz = 1
        xmin = 0
        xmax = 3.5
        ymin = 0.25
        ymax = 0.75
        zmin = 0
        zmax = 0.5
        elem_type = HEX8
        boundary_name_prefix = fluid
    []
    [solid]
        type = GeneratedMeshGenerator
        dim = 3
        nx = 20
        ny = 5
        nz = 1
        xmin = 0.5
        xmax = 1.5
        ymin = 0
        ymax = 0.25
        zmin = 0
        zmax = 0.5
        elem_type = HEX8
        boundary_name_prefix = solid
    []
    [stitched]
        type = StitchedMeshGenerator
        inputs = 'fluid solid'
        clear_stitched_boundary_ids = true
        stitch_boundaries_pairs = 'fluid_bottom solid_top'
        parallel_type = 'replicated'
    []
[]

[MultiApps]
    [hippo]
        type = TransientMultiApp
        app_type = hippoApp
        input_files = 'hippo.i'
        positions = '  0   0 0
                     0.5 0.5 0
                     0.6 0.6 0
                     0.7 0.7 0'
    []
[]
