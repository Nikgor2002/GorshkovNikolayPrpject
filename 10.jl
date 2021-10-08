using HorizonSideRobots
using Statistics

function movess!(r::Robot, side::HorizonSide)
    counter = 0
    while isborder(r, side) == false
        counter += 1
        move!(r, side)
    end
    return counter
end

function o(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
    end
end

function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side) + 2, 4))
end

function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end    

function movess!(r::Robot, side::HorizonSide)
    counter = 0
    while isborder(r, side) == false
        counter += 1
        move!(r, side)
    end
    return counter
end

function middle_temperature(r::Robot)
    massMiDLLE = []
    count_y = movess!(r, Nord)
    wer(r, Sud, count_y)
    count_x = movess!(r, Ost)
    wer(r, West, count_x)
    for y in 1:count_y+1
        for x in 1:count_x
            if isborder(r, Ost) == false
                if ismarker(r) == false
                    move!(r, Ost)
                else
                    push!(massMiDLLE, temperature(r))
                    move!(r, Ost)
                end
            end
        end
        o(r, West)
        if isborder(r, Nord) == false
            move!(r, Nord)
        else
            break
        end
    end
    println(mean(massMiDLLE))


                
end