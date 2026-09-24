@testset "Test Item Success Probability" begin
    a1 = 0.5
    b1 = 1.0
    c1 = 0.25

    θ = 1.5

    item_1pl = OnePLItem(b1)
    item_2pl = TwoPLItem(a1, b1)
    item_3pl = ThreePLItem(a1, b1, c1)

    one_pl_true = 1 / (1 + exp(-(θ - b1)))

    #testing 1pl items
    @test one_pl_true == prob(item_1pl, θ)
    @test prob(item_1pl, θ) <= 1.0
    @test prob(item_1pl, θ) >= 0

end