"""
A script to compare OpenFOAM and MOOSE meshes.

Requirements:

    pip install \\
        fluidfoam \\
        git+https://github.com/sandialabs/exodusii@2024.01.09 \\

You may also need to run an OpenFOAM post-processor to calculate the
enthalpy at each time step:

    buoyantFoam -postProcess -func totalEnthalpy

"""

import warnings
from pathlib import Path

import fluidfoam as ff
from exodusii.file import ExodusIIFile

warnings.filterwarnings("ignore", module=".*netcdf.*")

CASE_DIR = Path(__file__).parent
FOAM_DIR = CASE_DIR / "buoyantCavity"

moose_cp = 420  # J/kg/K
moose_rho = 0.2381  # kg/m3
moose_vol = 1 * 0.5 * 0.25  # 2 m3
moose_mass = moose_rho * moose_vol  # kg
moose_mesh = ExodusIIFile(str(CASE_DIR / "run_out.e"))
moose_t0 = moose_mesh.get_node_variable_values("temp",  1)
n_time_steps = moose_mesh.get_times().size
moose_t = moose_mesh.get_node_variable_values("temp",  n_time_steps)
moose_dt = moose_t - moose_t0
moose_de = moose_mass * moose_cp * moose_dt.sum()  # J

# OpenFOAM Enthalpy
ENTHALPY = "Ha"
foam_h0 = ff.readfield(str(FOAM_DIR), time_name="0", name=ENTHALPY, verbose=False)
foam_h = ff.readfield(str(FOAM_DIR), time_name="1", name=ENTHALPY, verbose=False)
foam_delta_h = (foam_h - foam_h0)

# Pressure energy (p*V)
PRESSURE = "p"
foam_vol = 0.5 * 0.5 * 0.5  # 2 m3
foam_p0 = ff.readfield(str(FOAM_DIR), time_name="0", name=PRESSURE, verbose=False)
foam_p = ff.readfield(str(FOAM_DIR), time_name="1", name=PRESSURE, verbose=False)
foam_pd = foam_p - foam_p0
foam_delta_pressure_energy = foam_vol * foam_pd

foam_de = (foam_delta_h - foam_delta_pressure_energy).sum()

print("MOOSE:               ΔQ = m.c.ΔT =", f"{moose_de:e}")
print("OpenFOAM:         ΔQ = ΔH - Δp.V =", f"{foam_de:e}")
print("Energy delta:              Δ(ΔQ) =", f"{moose_de - foam_de:e}")
