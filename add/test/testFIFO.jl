#=
testFIFO:
- Julia version: 
- Author: Анастасия
- Date: 2019-10-22
=#
include("../src/FIFO_f.jl")
using .FIFO_f
using Test
@testset "FIFO_step" begin
    step_Cadres1::Vector = Tuple{Int64,Int64}[(0, 0), (0, 0), (0, 0)]
    step_index1::Int = 0
    step_page1::Tuple = (1,1)
    @test FIFO_step(step_Cadres1, step_index1, step_page1) == (Tuple{Int64,Int64}[(1, 1), (0, 0), (0, 0)], 0)

    step_Cadres2::Vector = Tuple{Int64,Int64}[(1, 1), (0, 0), (0, 0)]
    step_index2::Int = 1
    step_page2::Tuple = (2,2)
    @test FIFO_step(step_Cadres2, step_index2, step_page2) == (Tuple{Int64,Int64}[(1, 1), (2, 2), (0, 0)], 1)
end