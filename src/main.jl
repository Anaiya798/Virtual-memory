#=
main:
- Julia version: 1.2
- Author: Анастасия
- Date: 2019-09-25
=#

function FIFO(Cadres, forder, page, i) #результат работы алгоритма FIFO
     k = true
     f = true
     badfifo = 0 #если нам пришлось делать замещение, то это "плохая" операция, считаем количество таких
    if page[i] in Cadres
        println("Текущая страница уже загружена")
        k = false
  end

     if   (Cadres[cadlen]==0 && k==true)
         g = findfirst(x->x==0,Cadres)
        Cadres[g]=page[i]
        println("Заменяем элемент в кадре " , g,  " на ", page[i])
        forder[page[i]] = i
        badfifo = badfifo + 1
        f = false
        end

     if(k==true && f==true)
        firstin=findall(x->x==argmin(forder),Cadres)
        println("Заменяем элемент в кадре " , firstin[1], " на ", page[i])
        forder[page[i]] = i
        Cadres[firstin[1]]=page[i]
        forder[argmin(forder)]=1000000
        badfifo = badfifo+1
  end
    if(k==true)
    println(Cadres)
    end
    return badfifo #возвращаем количество "плохих" операций
end



function LRU(Cadres, lorder, page, i) #результат работы алгоритма LRU
     k = true
     f = true
     badlru = 0 #если нам пришлось делать замещение, то это "плохая" операция, считаем количество таких
    if page[i] in Cadres
        println("Текущая cтраница уже загружена")
        k = false
        lorder[page[i]]=i
  end

     if   (Cadres[cadlen]==0 && k==true)
         g = findfirst(x->x==0,Cadres)
        Cadres[g]=page[i]
        println("Заменяем элемент в кадре " , g,  " на ", page[i])
        lorder[page[i]] = i
        f = false
        badlru = badlru + 1
        end

     if(k==true && f==true)
        firstin=findall(x->x==argmin(lorder),Cadres)
         println("Заменяем элемент в кадре " , firstin[1], " на ", page[i])
        lorder[page[i]] = i
        Cadres[firstin[1]]=page[i]
        lorder[argmin(lorder)]=1000000
        badlru = badlru + 1
  end
    if(k==true)
    println(Cadres)
    end
    return badlru #возвращаем количество "плохих" операций
end



function OPT(Cadres, otorder, page, i) #результат работы алгоритма OPT
     k = true
     f = true
     badopt = 0 #если нам пришлось делать замещение, то это "плохая" операция, считаем количество таких
    if page[i] in Cadres
        println("Текущая страница уже загружена")
        k = false
        optorder[page[i]]=optorder[page[i]]-1
  end

     if   (Cadres[cadlen]==0 && k==true)
         g = findfirst(x->x==0,Cadres)
        Cadres[g]=page[i]
        println("Заменяем элемент в кадре " , g,  " на ", page[i])
        optorder[page[i]] = optorder[page[i]]-1
        f = false
        badopt = badopt+1
        end

     if(k==true && f==true)
        firstin=findall(x->x==argmin(optorder),Cadres)
         println("Заменяем элемент в кадре " , firstin[1], " на ", page[i])
        optorder[page[i]] = optorder[page[i]]-1
        Cadres[firstin[1]]=page[i]
        optorder[argmin(optorder)]=1000000
        badopt = badopt+1
  end
    if(k==true)
    println(Cadres)
    end
    return badopt #возвращаем количество "плохих" операций
end



function efficiency(efifo, elru, eopt) #выявляем наиболее эффективный алгоритм замещения
    println("FIFO: ", efifo)
    println("LRU: ", elru)
    println("OPT: ", eopt)
    if(efifo>elru)
        println("LRU эффективнее")
        end
        if(elru > efifo)
            println("FIFO эффективнее")
            end
            if(efifo==elru)
                println("FIFO и  LRU одинаково эффективны")
                end
    end



println("Введите общее количество страниц ")
mempage=parse(Int64,readline())
println("Введите количество кадров")
cadlen=parse(Int64,readline())
Cadres=repeat([0],cadlen)
println("Введите по очереди индексы тех страниц, к которым будете обращаться")
page=[parse(Int,x) for x in split(readline())]
forder = repeat([1000000],mempage) #в массивах forder, lorder, optorder для каждой страницы будем хранить, какой по очереди она вошла в кадр
lorder = repeat([1000000],mempage)
optorder = repeat([0], length(page))::Array{Int64,1}
for i in 1:length(page)
optorder[page[i]]=1 +optorder[page[i]]
end
c=0



println("==")
println("Результат работы FIFO")
for i in 1:length(page)
global c = FIFO(Cadres, forder, page, i) + c
end
efifo = c/length(page) #выясняем процентное соотношение "плохих" операций в текущем алгоритме замещения
efifo = round(efifo; digits=2) * 100
println("==")
println(" ")


Cadres=repeat([0],cadlen)
c = 0



println("==")
println("Результат работы LRU")
for i in 1:length(page)
global c = LRU(Cadres, lorder, page, i) + c
end
elru = c/length(page) #выясняем процентное соотношение "плохих" операций в текущем алгоритме замещения
elru = round(elru; digits=2) * 100
println("==")
println(" ")


Cadres=repeat([0],cadlen)
c=0



println("==")
println("Результат работы OPT")
for i in 1:length(page)
global c = OPT(Cadres, optorder, page, i) + c
end
eopt = c/length(page)
eopt = round(eopt; digits=2) * 100 #выясняем процентное соотношение "плохих" операций в текущем алгоритме замещения
println("==")
println(" ")



println("==")
println("Процент замещений кадров по отношению к общему числу операций")
efficiency(efifo, elru, eopt) #вызываем функцию для выявления эффективного алгоритма
println("==")
println(" ")


