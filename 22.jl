using HorizonSideRobots
include("16.jl")
function  Ort_gone(r::Robot, side1::HorizonSide, alex::Bool)
    if alex == true
        return HorizonSide(mod(Int(side1) + 3, 4))
    else
        return HorizonSide(mod(Int(side1) + 1, 4))
    end
end

mass_main = []

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

function movess_2!(r::Robot, side::HorizonSide)
    counter = 0
    while isborder(r, side) == true
        counter += 1
        move!(r, Ort_gone(r, side, true))
    end
    return counter
end


function Bypassing_an_obstacle(r::Robot)
    array_of_temperatures = []
    counter = 0
    Temperature_value_start = temperature(r)::Int
    for side in [Ost, Nord, West, Sud]
        while isborder(r, side) == true
            push!(array_of_temperatures, temperature(r))
            if side == Sud
                move!(r, Ort_gone(r, side, true))
                counter += 1
            else
                move!(r, Ort_gone(r, side, true))
            end
        end
        push!(array_of_temperatures, temperature(r))
        move!(r, side)
        
    end
    
    while temperature(r)::Int != Temperature_value_start
        push!(array_of_temperatures, temperature(r))
        move!(r, Sud)
    end
    y_courd = movess_2!(r, Ost)
    move!(r, Ost)
    x_courd = movess_2!(r, Nord)
    wer(r, Nord, y_courd)
    return [x_courd + 1, array_of_temperatures, counter]
end

function Bypassing_an_obstacle_home(r::Robot)
    y_courd = movess_2!(r, West)
    move!(r, West)
    x_courd = movess_2!(r, Sud)
    wer(r, Sud, y_courd)
    return [x_courd + 1]
end

function proverka_masivov(r::Robot, mass_main::Any, x_2::Any)
    for i in 1:length(mass_main)
        if mass_main[i] == x_2
            return false
        end
    end
    return true 
end

function radar(r::Robot, x::Int, mass_main::Any)
    x = x - 1
    sum_counter = []
    while x > 0
        if isborder(r, Ost) == false
            move!(r, Ost)
            x -= 1
        else
            x_ = Bypassing_an_obstacle(r)
            xl = x_[1]
            x = x - xl
            if proverka_masivov(r, mass_main, x_[2]) == true
                push!(mass_main, x_[2])
                #println(mass_main)
            end
        end
        
    end
    #if length(mass_main) != 0
    #    return mass_main
    #end
end

function Returning_home(r::Robot, x::Int)
    x = x - 1
    
    sum_counter = []
    while x > 0
        if isborder(r, West) == false
            move!(r, West)
            x -= 1
        else
            x_ = Bypassing_an_obstacle_home(r)
            xl = x_[1]
            x = x - xl;

        end
        
    end
end
function maiiin(r::Robot)
    y = movess!(r, Nord)
    wer(r, Sud, y)
    x = movess!(r, Ost)
    wer(r, West, x)

    for j in 1:y
        radar(r, x+1, mass_main)
        Returning_home(r::Robot, x+1)
        if isborder(r, Nord) == false
            move!(r, Nord)
        else
            break
        end
    end

    return length(mass_main)
    
end
