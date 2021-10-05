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
    end
end    


    


function svj(r::Robot)
    o(r, Nord)
    bol::Bool = true
    a = 1
    while bol == true
        a = a + 1
        wer(r, Ost, a)
        if isborder(r, Nord) == false
            bol = false
            break
        end
        a = a + 1
        wer(r, West, a)
        if isborder(r, Nord) == false
            bol = false
            break
        end

        
        
    end
    
end