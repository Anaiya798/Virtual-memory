"""
# module FIFO_f

- Julia version: 
- Author: Анастасия
- Date: 2019-10-22

# Examples

```jldoctest
julia>
```
"""
module FIFO_f
    include("use_functions.jl")
    using .use_functions
    export FIFO

"Выполение  FIFO для одной страницы"
function FIFO_step(step_Cadres::Vector, step_index::Int, step_page::Tuple)
    if(Checking(step_Cadres, step_page[1]))
        step_index -= 1
    else
        step_Cadres[(step_index % length(step_Cadres)) + 1] = step_page

    end
    return (step_Cadres, step_index)
end

"Выполнение алгоритма FIFO для всех страниц (принимает страницы, которые нужно обработать, и размер оперативной памяти)"
function FIFO(FIFO_order::Vector, size::Int)
    Cadres = Fill_null(size) # заполняем кадры нулями
    index::Int = 0
    for i in 1:(length(FIFO_order))
        (Cadres, index) = FIFO_step(Cadres, index, FIFO_order[i]) # обработка очередной страницы
        index = index+1
        s = "fifo"
        Output(Cadres,s) # вывод текущего состояния кадров
    end
end

end