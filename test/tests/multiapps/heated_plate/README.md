# Heated Plate MultiApp

Here we solve the problem of fluid flowing over the top of a plate,
which is heated from the bottom.
The example is taken from this
[preCICE](http://precice.org/tutorials-flow-over-heated-plate.html) tutorial.

![Problem diagram](./doc/heated_plate.drawio.svg)

## OpenFOAM Mesh

The OpenFOAM mesh was created by generating a Gmsh mesh with MOOSE,
and then converting that to an OpenFOAM mesh
using OpenFOAM's `gmshToFoam` tool.

```hit
# fluid_mesh.i
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
[]
```

```bash
/path/to/hippo/hippo-opt -i fluid_mesh.i --mesh-only fluid.msh
cd buoyantCavity
gmshToFoam ../fluid.msh
```

I also updated the patch names in `buoyantCavity/constant/polyMesh/boundary`
so that they're consistent with the MOOSE mesh.
I just used paraview to ID which of the patches was left, right, top, etc..
