using HorizonSideRobots

function movess!(r::Robot, side::HorizonSide)
    counter = 0
    while isborder(r, side) == false
        counter += 1
        move!(r, side)
    end
    return counter
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

function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side) + 2, 4))
end





function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end   

function x(r::Robot)
    y = movess!(r, Sud)
    x = movess!(r, West)
    p_x = movess!(r, Nord)
    o(r, Sud)
    p_y = movess!(r, Ost)
    o(r, West)
    putmarker!(r)
    while isborder(r, Nord) == false && isborder(r, Ost) == false
        move!(r, Nord)
        move!(r, Ost)
        putmarker!(r)
    end
    o(r, West)
    putmarker!(r)
    while isborder(r, Sud) == false && isborder(r, Ost) == false
        move!(r, Sud)
        move!(r, Ost)
        putmarker!(r)
    end
    o(r, West)
    wer(r, Nord, y)
    wer(r, Ost, x)
end
