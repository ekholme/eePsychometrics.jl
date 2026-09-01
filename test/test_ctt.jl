function generate_binary_test_data(N=1_000, M=10, seed=0408)
    Random.seed!(seed)
    return simulate_1pl(N, M)
end

function generate_simple_binary_data()
    X = [1 1 1 1; 1 0 1 1; 1 0 1 0; 0 0 0 0]
    return X
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

@testset "Test Item Difficulty CTT" begin
    X = generate_binary_test_data()
    n = size(X, 1)
    m = size(X, 2)
    res = item_difficulty_ctt(X)

    @test length(res) == m
    @test 0 <= minimum(res) <= 1
    @test 0 <= maximum(res) <= 1

    X_known = generate_simple_binary_data()
    res_known = item_difficulty_ctt(X_known)
    truth = [0.75 0.25 0.75 0.5]
    @test res_known ≈ truth

    # testing method that takes a vector as input
    x = [1, 0, 1, 0]
    vec_res = item_difficulty_ctt(x)
    @test length(vec_res) == 1
    @test vec_res ≈ 0.5

end

@testset "Test Item Discrimination CTT" begin
    X = generate_binary_test_data()
    n = size(X, 1)
    m = size(X, 2)
    res = item_discrimination_ctt(X)

    @test res isa Vector{Float64}
    @test length(res) == m
    @test all(r -> isnan(r) || (-1 <= r <= 1), res)

    # Test with a known matrix
    X_known = generate_simple_binary_data()
    res_known = item_discrimination_ctt(X_known)

    truth = [0.5773502691896258, -0.5773502691896258, 0.5773502691896258, 0.5]
    @test res_known ≈ truth

    # Edge case: Item answered correctly by everyone
    X_all_correct = ones(Int, 5, 3)
    X_all_correct[:, 2] = [1, 1, 0, 0, 0] # one item with variance
    res_all_correct = item_discrimination_ctt(X_all_correct)
    @test isnan(res_all_correct[1])
    @test isnan(res_all_correct[3])
    @test !isnan(res_all_correct[2])

    # Edge case: Item answered incorrectly by everyone
    X_all_incorrect = zeros(Int, 5, 3)
    X_all_incorrect[:, 2] = [1, 1, 0, 0, 0] # one item with variance
    res_all_incorrect = item_discrimination_ctt(X_all_incorrect)
    @test isnan(res_all_incorrect[1])
    @test isnan(res_all_incorrect[3])
    @test !isnan(res_all_incorrect[2])
end