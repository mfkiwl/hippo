[Mesh]
  type = FoamMesh
  foam_args = '-case buoyantCavity'
  foam_patch = 'bottom'
  dim=2
[]

[Variables]
  [FOO]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 1
  []
[]

[AuxVariables]
  [T]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 300
  []
[]

[Problem]
  type=BuoyantFoamProblem
  output_variable = T
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 10
  dt = 0.2
  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
  [./TimeStepper]
    type = FoamTimeStepper
  [../]
[../]

[Outputs]
  exodus = true
[]
