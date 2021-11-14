using HorizonSideRobots

include("14.jl");include("5.jl");include("13.jl")

function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end

function  ft(p::Bool)
    if p == true
        return false
    else
        return true
    end
end

function prohod_16p(r::Robot, side::HorizonSide, val::Bool)
    counter = 0
    if val == true
        while isborder(r, side) == true
            counter += 1
            move!(r, Ort_gone(r, side,  val))
        end
    else
        while isborder(r, side) == true
            counter += 1
            move!(r, Ort_gone(r, side,  val))
        end
    end
    return counter
end

function obhod_prum_16p(r::Robot, side::HorizonSide, val::Bool)
    counter = prohod_16p(r, side, val)
    move!(r, side)
    while isborder(r, Ort_gone(r, side,  ft(val))) == true
        move!(r, side)
    end
    wer(r,Ort_gone(r, side,  ft(val)), counter )

end

function idem_and_stavim_markers_16p(r::Robot, side::HorizonSide, val::Bool)
    gr = true
    while gr == true
        if isborder(r, side) == false
            putmarker!(r)
            move!(r, side)
        else
            putmarker!(r)
            bol = obhod_prum_16p(r, side, val)
            if bol == false
                break
            end
        end
    end
end

function PAINT_field(r::Robot)
    qw = size_Kvatro(r::Robot)
    
    north_counter = movess!(r, Nord)
    o(r, Sud)
    for _ in 1:north_counter + 1
        idem_and_stavim_markers(r, Ost)
        idem_and_stavim_markers(r, West)
        if isborder(r, Nord) == true
            o(r, Sud)
            o(r, West)
            break
        else
            move!(r, Nord)
        end
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
