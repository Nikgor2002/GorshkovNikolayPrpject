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


function perimetr(r::Robot)
    north_counter = movess!(r, Nord)
    ost_counter = movess!(r, Ost)

    for side in (Sud, West, Nord, Ost)
        idem_and_stavim_markers(r, side)
    end
    
    wer(r, Sud, north_counter)
    wer(r, West, ost_counter)

end




