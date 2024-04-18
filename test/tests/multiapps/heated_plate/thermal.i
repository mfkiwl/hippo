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
        family = LAGRANGE
        order = FIRST
        initial_condition = 300
    []
[]

[Kernels]
    [heat-conduction]
        type = ADHeatConduction
        variable = T
    []
    [heat-conduction-dt]
        type = ADHeatConductionTimeDerivative
        variable = T
    []
[]

[BCs]
    [fixed_temp]
        type = DirichletBC
        variable = T
        boundary = solid_bottom
        value = 310
    []
[]

[Materials]
    [thermal-density]
        type = ADGenericConstantMaterial
        prop_names = 'density'
        prop_values = 0.2381
    []
    [thermal-conduction]
        type = ADHeatConductionMaterial
        specific_heat = 420
        thermal_conductivity = 100
    []
[]

[Executioner]
    type = Transient
    end_time = 1
    dt = 0.05

    solve_type = 'PJFNK'

    petsc_options = '-snes_ksp_ew'
    petsc_options_iname = '-pc_type -pc_hypre_type'
    petsc_options_value = 'hypre boomeramg'
    l_tol = 1e-6
    nl_abs_tol = 1e-9
    nl_rel_tol = 1e-8
[]

[Outputs]
    exodus = true
[]
