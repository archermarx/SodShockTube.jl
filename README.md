# SodShockTube

[![Build Status](https://github.com/archermarx/SodShockTube.jl/workflows/CI/badge.svg)](https://github.com/archermarx/SodShockTube.jl/actions)

This is a pure-Julia implementation of the python Sod Shock tube solver by ibackus (https://github.com/ibackus/sod-shocktube), which is "a fork of the Riemann solver implemented at https://gitlab.com/fantaz/Riemann_exact, which is itself just a pythonic clone of the fortran code by Bruce Fryxell."

The Sod Shock Tube Problem is a standard test problem in computational fluid dynamics. It is especially useful in the development of shock-capturing numerical schemes. This package allows users to set up and run Sod Shock Tube problems with user-configurable geometry and user-defined left and right states.

# Example

```julia

# Set up a shock tube problem
problem = ShockTubeProblem(
    geometry = (0.0, 1.0, 0.5), # left edge, right edge, initial shock location
    left_state = (ρ = 1.0, u = 0.0, p = 1.0),
    right_state = (ρ = 0.125, u = 0.0, p = 0.1),
    t = 0.1,
    γ = 1.4
);

xs = LinRange(0.0, 1.0, 500); # x locations at which to solve

positions, regions, values = solve(problem, xs);
```

This should give the following result

```julia-repl
julia> positions
Dict{String, Float64} with 4 entries:
  "Shock"                 => 1.17522
  "Foot of rarefaction"   => 0.992973
  "Head of rarefaction"   => 0.881678
  "Contact Discontinuity" => 1.09275

julia> regions
Dict{String, Any} with 5 entries:
  "Region 5" => (0.1, 0.125, 0.0)
  "Region 1" => (1.0, 1.0, 0.0)
  "Region 4" => (0.30313, 0.265574, 0.927453)
  "Region 3" => (0.30313, 0.426319, 0.927453)
  "Region 2" => "RAREFACTION"
```

We can use Makie (or other plotting package of choice) to plot our result

```julia
using CairoMakie
f = Figure(resolution = (1000, 1000))
ax_ρ = Axis(f[1,1], xlabel = "x", ylabel = "ρ", title = "Density")
ax_u = Axis(f[2,1], xlabel = "x", ylabel = "u", title = "Velocity")
ax_p = Axis(f[1,2], xlabel = "x", ylabel = "p", title = "Pressure")
ax_E = Axis(f[2,2], xlabel = "x", ylabel = "E", title = "Stagnation Energy")

opts = (;linewidth = 4)

lines!(ax_ρ, values.x, values.ρ; opts...)
lines!(ax_u, values.x, values.u; opts...)
lines!(ax_p, values.x, values.p; opts...)
lines!(ax_E, values.x, values.e; opts...)

display(f)
```

![](https://github.com/archermarx/SodShockTube.jl/blob/main/test/fig.png)



