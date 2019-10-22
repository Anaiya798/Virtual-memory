#=
testUse_functions:
- Julia version: 
- Author: Анастасия
- Date: 2019-10-22
=#
include("../src/use_functions.jl")
using .use_functions
using Test
@testset "Fill_null" begin
@test Fill_null(4) == Tuple{Int64,Int64}[(0, 0), (0, 0), (0, 0), (0, 0)]
@test Fill_null(3) == Tuple{Int64,Int64}[(0, 0), (0, 0), (0, 0)]
end

@testset "Indexing" begin
vector_page1::Vector = [1, 2]
@test Indexing(vector_page1) == (Tuple{Int64,Int64}[(1, 1), (2, 2)])
vector_page2::Vector = [1, 2, 3, 3]
@test Indexing(vector_page1) == (Tuple{Int64,Int64}[(1, 1), (2, 2), (3, 3), (3, 4)])
end

@testset "Checking" begin
    cur_Cadres1::Vector = Tuple{Int64,Int64}[(0, 0), (0, 0), (0, 0)]
    cur_page1::Int64 = 1
    @test Checking(cur_Cadres1, cur_page1) == false
    cur_Cadres2::Vector = Tuple{Int64,Int64}[(1, 1)]
    cur_page2::Int64 = 1
    @test Checking(cur_Cadres2, cur_page2) == true

end