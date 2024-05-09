[Mesh]
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
[]

[Variables]
    [T]
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
    [thermal]
        type = TransientMultiApp
        input_files = 'thermal.i'
        positions = '0 0 0
                     0 0 0
                     0 0 0
                     0 0 0'
    []
[]

[Executioner]
    type = Transient
    start_time = 0
    end_time = 1
    dt = 0.01

    solve_type = 'PJFNK'

    petsc_options_iname = '-pc_type -pc_hypre_type'
    petsc_options_value = 'hypre boomeramg'
[]
