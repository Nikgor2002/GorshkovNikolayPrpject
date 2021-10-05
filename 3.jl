using HorizonSideRobots

function idem_and_stavim_markers(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
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


function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end

function roundo(r::Robot)
    putmarker!(r)
    idem_and_stavim_markers(r, West)
    if isborder(r, Sud) == false
        move!(r, Sud)
    end
    putmarker!(r)
    idem_and_stavim_markers(r, Ost)
  
    
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function Sasha(r::Robot)
    N_cc = movess!(r, Nord)
    O_cc = movess!(r, Ost)
    weight_count = movess!(r, Sud)
    wer(r, Nord, weight_count)
    dolgetude_count = movess!(r, West)
    wer(r, Ost, dolgetude_count)
    println(weight_count, dolgetude_count)

    if (weight_count + 1) % 2 == 0
        for _ in 1:2:weight_count
            roundo(r)
            move!(r, Sud)
        end
        
    else
        for _ in 1:2:weight_count 
            roundo(r)
            move!(r, Sud)
        end
    end
    putmarker!(r)
    idem_and_stavim_markers(r, West)
    wer(r, Nord, weight_count - N_cc)
    wer(r,  Ost,  dolgetude_count - O_cc )

end



