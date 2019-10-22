"""
# module Lib

- Julia version: 
- Author: Анастасия
- Date: 2019-10-22

# Examples

```jldoctest
julia>
```
"""
module Lib
include("FIFO_f.jl")
include("OPT_f.jl")
include("use_functions.jl")
include("LRU_f.jl")
using .LRU_f
using .use_functions
using .FIFO_f
using .OPT_f
export id

function id(x)
    @info "Program running" x
    println("Введите общее количесвто страниц ")
    n = parse(Int, readline()) # считываем количества страниц
    println("Введите по очереди номера страниц, к которым будете обращаться ")
    Pages = Indexing(Read(n)) # считывание и индексация страниц
    println("Введите количество кадров ")
    n = parse(Int, readline()) # считываем размер оперативной памяти
    @info "Input taken" x

     file = open("fifo.txt", "w") do file
     @debug "fifo.txt opened" x
    write(file, "Результат работы FIFO \n")
    close(file)
    @debug "fifo.txt closed" x
    end
     @info "Went to module FIFO"
    FIFO(Pages, n) # выполнение алгоритма FIFO, результат его работы запишем в файл


   file = open("lru.txt", "w") do file
    @debug "lru.txt opened" x
    write(file, "Результат работы LRU \n")
    close(file)
    @debug "lru.txt closed" x
    end
     @info "Went to module LRU"
    LRU(Pages, n) #выполнение алгоритма LRU, открываем файл для записи результатов

    file = open("opt.txt", "w") do file
    @debug "opt.txt opened" x
    write(file, "Результат работы OPT \n")
    close(file)
    @debug "opt.txt closed" x
    end
     @info "Went to module OPT"
    OPT(Pages, n) # выполнение алгоритма OPT
    return x
end


end