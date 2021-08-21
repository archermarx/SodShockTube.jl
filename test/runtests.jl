using SodShockTube
using CairoMakie
using Test
using Documenter

doctest(SodShockTube)

@testset "SodShockTube.jl" begin
    problem = ShockTubeProblem(
        geometry = (0.0, 1.0, 0.5),
        left_state = (ρ = 1.0, u = 0.0, p = 1.0),
        right_state = (ρ = 0.125, u = 0.0, p = 0.1),
        t = 0.2,
        γ = 1.4
    );
    xs = LinRange(0.0, 1.0, 500);
    positions, regions, values = solve(problem, xs)
    @test positions["Shock"] ≈ 0.8504311464060357
    @test positions["Contact Discontinuity"] ≈ 0.6854905240097902
    @test positions["Head of rarefaction"] ≈ 0.26335680867601535
    @test positions["Foot of rarefaction"] ≈ 0.4859454374877634

    @test all(regions["Region 1"] .≈ (1.0, 1.0, 0.0))
    @test regions["Region 2"] == "RAREFACTION"
    @test all(regions["Region 3"] .≈ (0.30313017804679177, 0.42631942817462254, 0.9274526200369384))
    @test all(regions["Region 4"] .≈ (0.30313017805064707, 0.26557371170530725, 0.92745262004895057))
    @test all(regions["Region 5"] .≈ (0.1, 0.125, 0.0))

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

    save("test/fig.png", f, px_per_unit=3)
end
