function generate_binary_test_data(N=1_000, M=10, seed=0408)
    Random.seed!(seed)
    return simulate_1pl(N, M)
end

@testset "Test Total Scores CTT" begin
    X = generate_binary_test_data()
    n = size(X, 1)
    m = size(X, 2)
    res = total_scores(X)
    @test length(res) == n
    @test 0 <= minimum(res) <= m
    @test 0 <= maximum(res) <= m

    # Test with a known matrix
    X_known = [1 0 1; 0 1 1; 1 1 1]
    @test total_scores(X_known) == [2; 2; 3;;]

    # Test edge cases
    @test total_scores(zeros(Int, 2, 5)) == zeros(Int, 2, 1)
    @test total_scores(ones(Int, 3, 4)) == [4; 4; 4;;]

    @test_throws MethodError total_scores("a")
end

@testset "Test Mean Scores CTT" begin
    X = generate_binary_test_data()
    n = size(X, 1)
    res = mean_scores(X)
    @test length(res) == n
    @test 0 <= minimum(res) <= 1
    @test 0 <= maximum(res) <= 1

    # Test with a known matrix
    X_known = [1 0 1 0; 0 1 1 0; 1 1 1 1]
    @test mean_scores(X_known) ≈ [0.5; 0.5; 1.0;;]

    # Test edge cases
    @test mean_scores(zeros(Int, 2, 5)) == zeros(Float64, 2, 1)
    @test mean_scores(ones(Int, 3, 4)) == ones(Float64, 3, 1)

    @test_throws MethodError mean_scores("a")
end