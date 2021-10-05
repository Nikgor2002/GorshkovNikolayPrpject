using HorizonSideRobots



function  inverse(side::HorizonSide)
    HorizonSide(mod(Int(side) + 2, 4))
end

function idem_and_stavim_markers(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
    end
end

function move_by_markers(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        move!(r, side)
    end
end

function fin(r::Robot)
    for side in (Nord, Ost, Sud, West)
        idem_and_stavim_markers(r, side)
        move_by_markers(r, inverse(side))
    end
    putmarker!(r)
    
end