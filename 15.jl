using HorizonSideRobots

include("5.jl")
include("2.jl")


function main(r::Robot)
    qw = size_Kvatro(r::Robot)
    for side in (Nord, Ost, Sud, West)
        idem_and_stavim_markers(r, side)
    end
    massX_2 = qw[1]
    massX_2 = reverse!(massX_2)
    for i in 1:length(massX_2)
        fcope = massX_2[i]
        fcope[2] = inverse(fcope[2])
        if fcope[2] == West && fcope[2] == Ost
            wer(r, fcope[2], fcope[1])
        else
            wer(r, fcope[2], fcope[1])
            
        end
    end
end
___

"""
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
        wer(r, Ort_gone(r, side, val), v)
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
    """