[Mesh]
    [solid]
        type = GeneratedMeshGenerator
        dim = 3
        nx = 50
        ny = 50
        nz = 1
        xmin = 0
        xmax = 0.02
        ymin = 0
        ymax = 0.01
        zmin = 0
        zmax = 0.01
        elem_type = HEX8
        boundary_name_prefix = solid
    []
[]

[MultiApps]
    [hippo]
        type = TransientMultiApp
        app_type = hippoApp
        execute_on = timestep_begin
        input_files = 'fluid.i'
    []
[]

[Transfers]
    [T_from_fluid]
        type = MultiAppGeometricInterpolationTransfer
        source_variable = T
        from_multi_app = hippo
        variable = fluid_T
    []

    [T_to_fluid]
        type = MultiAppGeometricInterpolationTransfer
        source_variable = temp
        to_multi_app = hippo
        variable = T
    []
[]

[Variables]
    [temp]
        family = LAGRANGE
        order = FIRST
        initial_condition = 310
    []
[]

[AuxVariables]
    [fluid_T]
        family = LAGRANGE
        order = FIRST
        initial_condition = 300
    []
[]

[Kernels]
    [heat-conduction]
        type = ADHeatConduction
        variable = temp
    []
    [heat-conduction-dt]
        type = ADHeatConductionTimeDerivative
        variable = temp
    []
[]

[BCs]
    [fluid_interface]
        type = CoupledVarNeumannBC
        variable = temp
        boundary = solid_top
        v = fluid_T
    []
[]

[Materials]
    [thermal-density]
        type = ADGenericConstantMaterial
        prop_names = 'density'
        prop_values = 500
    []
    [thermal-conduction]
        type = ADHeatConductionMaterial
        specific_heat = 100
        thermal_conductivity = 400
    []
[]

[Executioner]
    type = Transient
    start_time = 0
    end_time = 10
    dt = 0.2

    solve_type = 'PJFNK'

    # petsc_options = '-snes_ksp_ew'
    petsc_options_iname = '-pc_type -pc_hypre_type'
    petsc_options_value = 'hypre boomeramg'
    l_tol = 1e-6
    nl_abs_tol = 1e-9
    nl_rel_tol = 1e-8
[]

[Outputs]
    exodus = true
[]
