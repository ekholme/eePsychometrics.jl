# helper functions for testing

function generate_binary_test_data(N=1_000, M=10, seed=0408)
    Random.seed!(seed)
    return simulate_1pl(N, M)
end

function generate_simple_binary_data()
    X = [1 1 1 1; 1 0 1 1; 1 0 1 0; 0 0 0 0]
    return X
end
