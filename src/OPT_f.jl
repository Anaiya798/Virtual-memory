"""
# module OPT_f

- Julia version: 
- Author: Анастасия
- Date: 2019-10-22

# Examples

```jldoctest
julia>
```
"""
module OPT_f
    include("use_functions.jl")
    using .use_functions
    export OPT

    function find_next_call(call_page::Tuple, pages::Vector, cur_index::Int)
    next_call::Int = length(pages) # изначально расстояние до следующего вызова данной страницы равна длине всего списка (возможно, к ней больше обращаться не будут)
    for i in cur_index:length(pages)
        if(pages[i][1] == call_page[1])
            next_call = i - call_page[2] # изменение расстояния до следующего вызова данной страницы, если она все же вызывается
            break
        end
    end
    return next_call
end

function opt_to_del_search(Cadres::Vector, pages::Vector, cur_index::Int)
    opt_to_del::Int = 1
    max_way::Int = 0
    for i in 1:length(Cadres)
        if(Cadres[i][2] == 0)
            return i
        end
        cur_way::Int = find_next_call(Cadres[i], pages, cur_index)
        if(cur_way > max_way)
            max_way = cur_way
            opt_to_del = i
        end
    end
    return opt_to_del
end # поиск оптимального  для замещения элемента в кадрах(функция возвращает индекс данного элемента)

function changing(cur_Cadres::Vector, cur_page::Tuple)
    for i in 1:length(cur_Cadres)
        if(cur_Cadres[i][1] == cur_page[1])
            cur_Cadres[i] = cur_page
        end
    end
    return cur_Cadres
end

function OPT_step(step_Cadres::Vector, step_page::Tuple, pages::Vector, cur_index::Int)

    if(!Checking(step_Cadres, step_page[1]))
        step_Cadres[opt_to_del_search(step_Cadres, pages, cur_index)] = step_page
    else
        step_Cadres = changing(step_Cadres, step_page)
    end
    return(step_Cadres)
end # выполнение OPT для одной страницы
function OPT(OPT_order::Vector, size::Int)
    Cadres = Fill_null(size) # заполняем кадры изначально нулями
    for i in 1:(length(OPT_order))
        Cadres = OPT_step(Cadres, OPT_order[i],  OPT_order, i) # выполнение OPT для одной страницы
        s = "opt"
        Output(Cadres, s) # вывод текущего состояния кадров на данном шаге алгоритма
    end

end # выполнение OPT для всех страниц
end