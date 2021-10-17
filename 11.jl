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

function colco(r::Robot, side::HorizonSide)
    
    if side == Ost
        counter = 0
        if isborder(r, Ost) == false
            move!(r, Ost)
            putmarker!(r)
            move!(r, West)
        else
            while isborder(r, Ost) == true
                counter += 1
                move!(r, Sud)
            end
            
            move!(r, Ost)
            while isborder(r, Nord) == true
                move!(r, Ost)
            end
            wer(r, Nord, counter)
            putmarker!(r)
            while isborder(r, West) == true
                move!(r, Nord)
            end
            
            move!(r, West)
            while isborder(r, Sud) == true
                move!(r, West)
            end
            while ismarker(r) == false
                move!(r, Sud)
            end

           
        end
    end
end

function myfun(r::Robot)
    putmarker!(r)
    colco(r, Ost)
end
