#=
testLRU:
- Julia version: 
- Author: Анастасия
- Date: 2019-10-22
=#
include("../src/LRU_f.jl")
using .LRU_f
using Test
@testset "find_next_call" begin
  Cadres1::Vector = Tuple{Int64,Int64}[(1, 1)]
  @test min_index(Cadres1) == 1
  Cadres2::Vector = Tuple{Int64,Int64}[(3, 2)]
   @test min_index(Cadres2) == 2
end
@testset "changing" begin
    cur_Cadres1::Vector = Tuple{Int64,Int64}[(3, 3), (2, 2)]
     cur_page1::Tuple = (2, 4)
     @test changing(cur_Cadres1, cur_page1) == (Tuple{Int64,Int64}[(3, 3), (2, 4)])
     cur_Cadres2::Vector = Tuple{Int64,Int64}[(1, 1), (2, 2)]
     cur_page2::Tuple = (2, 3)
     @test changing(cur_Cadres1, cur_page1) == (Tuple{Int64,Int64}[(1, 1), (2, 3)])
end
@testset "LRU_step" begin
    step_Cadres1::Vector = Tuple{Int64,Int64}[(0, 0), (0, 0), (0, 0)]
     step_page1::Tuple = (1, 1)
     @test LRU_step(step_Cadres1, step_page1) == (Tuple{Int64,Int64}[(1, 1), (0, 0), (0, 0)])
     step_Cadres2::Vector = Tuple{Int64,Int64}[(1, 1), (0, 0), (0, 0)]
     step_page2::Tuple = (2, 2)
     @test LRU_step(step_Cadres2, step_page2) == (Tuple{Int64,Int64}[(1, 1), (2, 2), (0, 0)])
end