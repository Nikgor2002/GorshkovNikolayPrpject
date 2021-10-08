using HorizonSideRobots

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
        if ismarker(r) == true
            return 0
            break
        end
    end
end    


function Roma(r::Robot)
    a = 1
    f = 0
    
    while ismarker(r) == false
        k = wer(r, HorizonSide(f%4), a)
        if k == 0
            break
        end
        f += 1
        k = wer(r, HorizonSide(f%4), a)
        if k == 0
            break
        end
        a += 1
        f += 1
    end 
end
