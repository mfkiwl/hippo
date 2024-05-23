[Mesh]
  type = FoamMesh
  foam_args = '-case buoyantCavity'
  foam_patch = 'topAndBottom frontAndBack'
  dim=2
[]
[AuxVariables]
  [T]
    initial_condition = 1.0
  []
[]
[Variables]
  [foamT_face]
    family = MONOMIAL
    order = CONSTANT
  []
  # Note that this test crashes if [FOO] is declared first...
  [FOO]
    initial_condition = 10.0
  []
[]
[Problem]
  type=BuoyantFoamProblem
  output_variable = foamT_face
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 11
  dt = 0.1
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
