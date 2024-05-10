[Mesh]
  type = FoamMesh
  foam_args = '-case buoyantCavity'
  foam_patch = 'fluid_bottom'
  dim=2
[]

[AuxVariables]
  [T]
    initial_condition = 250
  []
[]

[Variables]
[]

[Problem]
  type=BuoyantFoamProblem
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
[../]

[Outputs]
  exodus = true
[]
