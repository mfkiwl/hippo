[Mesh]
    [fluid]
        type = GeneratedMeshGenerator
        dim = 2
        nx = 70
        ny = 15
        xmin = 0
        xmax = 3.5
        ymin = 0.25
        ymax = 0.75
        elem_type = QUAD4
        boundary_name_prefix = fluid
    []
    [solid]
        type = GeneratedMeshGenerator
        dim = 2
        nx = 20
        ny = 5
        xmin = 0.5
        xmax = 1.5
        ymin = 0
        ymax = 0.25
        elem_type = QUAD4
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
