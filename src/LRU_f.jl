"""
# module LRU_f

- Julia version: 
- Author: Анастасия
- Date: 2019-10-22

# Examples

```jldoctest
julia>
```
"""
module LRU_f
    include("use_functions.jl")
    using .use_functions
    export LRU


    function min_index(Cadres::Vector)
    find_minimum::Int = Cadres[1][2]
    for i in 1:length(Cadres)
        if(Cadres[i][2] == 0)
            return i
        end
        if(Cadres[i][2] < find_minimum && Cadres[i][2] != 0)
            find_minimum = Cadres[i][2]
        end
    end
    return find_minimum
end # ищем страницу, которая была добавлена в кадры раньше всех

function changing(cur_Cadres::Vector, cur_page::Tuple)
    for i in 1:length(cur_Cadres)
        if(cur_Cadres[i][1] == cur_page[1])
            cur_Cadres[i] = cur_page
        end
    end
    return cur_Cadres
end # если страница, уже загруженная в кадры, вызывается повторно, меняем ее индекс


function LRU_step(step_Cadres::Vector, step_page::Tuple)
    if(!Checking(step_Cadres, step_page[1]))
        step_Cadres[min_index(step_Cadres)] = step_page
    else
        step_Cadres = changing(step_Cadres, step_page)
    end
    return (step_Cadres)
end # выполнение LRU для одной страницы

function LRU(LRU_order::Vector, size::Int)
    Cadres = Fill_null(size)
    for i in 1:(length(LRU_order))
        Cadres = LRU_step(Cadres, LRU_order[i])
        s = "lru"
        Output(Cadres, s)
    end

end # выполнение LRU для всех страниц
end