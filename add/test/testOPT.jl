#=
testOPT:
- Julia version: 
- Author: Анастасия
- Date: 2019-10-22
=#
include("../src/OPT_f.jl")
using .OPT_f
using Test
@testset "find_next_call" begin
 call_page1::Tuple = (1, 1)
 pages1::Vector = Tuple{Int64,Int64}[(1, 1), (2, 2)]
 cur_index1::Int = 2
  @test find_next_call(call_page1, pages1, cur_index1) == 2
  call_page2::Tuple = (2, 2)
 pages2::Vector =Tuple{Int64,Int64}[(1, 1), (2, 2), (3, 3), (2, 4)]
 cur_index2::Int = 3
  @test find_next_call(call_page2, pages2, cur_index2) == 2
end

@testset "opt_to_del_search" begin
    Cadres1::Vector = Tuple{Int64,Int64}[(3, 3)]
 pages1::Vector = TTuple{Int64,Int64}[(1, 1), (2, 2), (3, 3), (4, 4)]
 cur_index1::Int = 4
  @test opt_to_del_search(Cadres1, pages1, cur_index1) == 1
  Cadres2::Vector = Tuple{Int64,Int64}[(2, 2)]
  pages2::Vector = Tuple{Int64,Int64}[(1, 1), (2, 2), (3, 3), (4, 4)]
 cur_index2::Int = 3
  @test opt_to_del_search(Cadres2, pages2, cur_index2) == 1
end

@testset "OPT_step" begin
    step_Cadres1::Vector = Tuple{Int64,Int64}[(0, 0), (0, 0), (0, 0)]
     step_page1::Tuple = (1, 1)
     pages1::Vector = Tuple{Int64,Int64}[(1, 1), (2, 2)]
      cur_index1::Int = 1
     @test OPT_step(step_Cadres1, step_page1, pages1, cur_index1) == (Tuple{Int64,Int64}[(1, 1), (0, 0), (0, 0)])
     step_Cadres2::Vector = Tuple{Int64,Int64}[(1, 1), (0, 0), (0, 0)]
     step_page2::Tuple = (2, 2)
     pages2::Vector = Tuple{Int64,Int64}[(1, 1), (2, 2)]
      cur_index2::Int = 2
     @test OPT_step(step_Cadres2, step_page2, pages2, cur_index2) == (Tuple{Int64,Int64}[(1, 1), (2, 2), (0, 0)])

end