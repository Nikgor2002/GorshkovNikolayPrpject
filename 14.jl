using HorizonSideRobots


function movess!(r::Robot, side::HorizonSide)
    counter = 0
    while isborder(r, side) == false
        counter += 1
        move!(r, side)
    end
    return counter
end

function falsetrue(arg::Int)
    if arg == 0
        return false
    else
        return true
    end    
end

function  inverse(side::HorizonSide)
    HorizonSide(mod(Int(side) + 2, 4))
end

function  Ort_gone(r::Robot, side1::HorizonSide, alex::Bool)
    if alex == true
        return HorizonSide(mod(Int(side1) + 3, 4))
    else
        return HorizonSide(mod(Int(side1) + 1, 4))
    end
end


function movesss!(r::Robot, side1::HorizonSide, side2::HorizonSide)
    counter = 0
    while isborder(r, side2) == true
        counter += 1
        move!(r, side1)
    end
    return counter
end

function o(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
    end
end




function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end   

function prohod(r::Robot, side::HorizonSide)
    v = 0
    v_counter_x_plus = 0
    v_counter_x_minus = 0
    julia = false
    while isborder(r, side) == true
        v = v + 1
        if (isborder(r, Ort_gone(r, side, false)) == true && isborder(r, side) == true) || (isborder(r, Ort_gone(r, side, true)) == true && isborder(r, side) == true)
            mass_1 = [v_counter_x_minus, julia, false]
            mass_2 = [v_counter_x_plus, julia, false]
            if julia == true
                return mass_1
            else
                return mass_2
            end
        end
        wer(r, Ort_gone(r, side, julia), v)
        if Ort_gone(r, side, julia) == Ort_gone(r, side, false)
            v_counter_x_minus += 1
        else
            v_counter_x_plus += 1
        end
        if julia == true
            julia = false
        else
            julia = true
        end
        
    end
    mass_1 = [v_counter_x_minus, julia, true]
    mass_2 = [v_counter_x_plus, julia, true]
    if julia == true
        return mass_1
    else
        return mass_2
    end
end



function obhod_prum(r::Robot, side::HorizonSide)
    mass = prohod(r, side)
    counter = mass[1]
    st = mass[2]
    stb = mass[3]
    if stb == true
        move!(r, side)
        while isborder(r, Ort_gone(r, side, falsetrue(st))) == true
            move!(r, side)
        end
        move!(r, Ort_gone(r, side, falsetrue(st)))
        wer(r, Ort_gone(r, side,falsetrue(st)), counter-1)
        return true
    else
        wer(r, Ort_gone(r, side,falsetrue(st)), counter)
        return false
    end
end


function idem_and_stavim_markers(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
        while isborder(r, side) == true
            putmarker!(r)
            bol = obhod_prum(r, side)
            if bol == false
                break
            end
        end
        putmarker!(r)
    end
end

function move_by_markers(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        while isborder(r, side) == true
            obhod_prum(r, side)
        end
        move!(r, side)
    end
end


###
function plus(r::Robot)
    for side in (Nord, Ost, Sud, West)
        idem_and_stavim_markers(r, side)
        move_by_markers(r, inverse(side))
    end
    putmarker!(r)
    
end

    
