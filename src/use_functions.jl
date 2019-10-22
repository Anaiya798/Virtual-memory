"""
# module use_functions

- Julia version: 
- Author: Анастасия
- Date: 2019-10-22

# Examples

```jldoctest
julia>
```
"""
module use_functions
    export Read
    export Fill_null
    export Output
    export Indexing
    export Checking

    function Read(n::Int)
    readData = Vector{Int64}()
    readData = [parse(Int64, x) for x in split(readline())]
    return readData
end # функция принимает число страниц, которые нужно считать,  и возвращает их в форме массива

function Fill_null(size::Int)
    Cadres= Tuple{Int64, Int}[]
    for i in 1:size
        push!(Cadres, tuple(0, 0))
    end
    return Cadres
end # заполняем кадры нулями

function Output(cur_Cadres::Vector, s::String)
    if(s=="fifo") file = open("fifo.txt", "a")
         end
    if(s=="lru") file = open("lru.txt", "a")
           end
     if(s=="opt") file = open("opt.txt", "a")
           end
    write(file, "[")
    for i in 1:length(cur_Cadres)
       write(file, "$(cur_Cadres[i][1])")
       if(i!= length(cur_Cadres)) write(file, ", ")
           end
    end
    write(file, "]")
    close(file)
    end # записываем в файлы состояние кадров на текущем шаге каждого из алгоритмов замещения
function Indexing(vector_page::Vector)
    index_vector = Tuple{Int64, Int}[]
    for i in 1:length(vector_page)
        push!(index_vector, tuple(vector_page[i], i))
    end
    return index_vector
end # функция принимает массив страниц и создает из него массив пар "номер страницы - индекс"

function Checking(cur_Cadres::Vector, cur_page::Int64)
    isFound = false
    for i in 1:length(cur_Cadres)
        if(cur_Cadres[i][1] == cur_page)
            isFound = true
                break
        end
    end
    return isFound
end # функция принимает текущее состояние кадров и текущую страницу; возвращает true, если данная страница уже загружнена в кадры

end
