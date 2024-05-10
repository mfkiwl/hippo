# [Mesh]
#     [solid]
#         type = GeneratedMeshGenerator
#         dim = 3
#         nx = 20
#         ny = 5
#         nz = 1
#         xmin = 0.5
#         xmax = 1.5
#         ymin = 0
#         ymax = 0.25
#         zmin = 0
#         zmax = 0.5
#         elem_type = HEX8
#         boundary_name_prefix = solid
#     []
#     [fluid]
#         type = FoamMesh
#         foam_args = '-case buoyantCavity'
#         foam_patch = 'fluid_bottom'
#         dim=2
#     []
# []

[AuxVariables]
    [T]
    []
[]

[MultiApps]
    [hippo]
        type = TransientMultiApp
        mesh = fluid
        app_type = hippoApp
        input_files = 'hippo.i'
        positions = '0 0 0
                     0 0 0
                     0 0 0
                     0 0 0'
    []
    [thermal]
        type = TransientMultiApp
        mesh = solid
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
    dt = 0.05

    solve_type = 'PJFNK'

    petsc_options_iname = '-pc_type -pc_hypre_type'
    petsc_options_value = 'hypre boomeramg'
    [./TimeStepper]
        type = FoamTimeStepper
    [../]
[]
