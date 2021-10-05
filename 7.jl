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

function Chess(r::Robot)
    count_x_home = movess!(r, Sud)
    count_y_home = movess!(r, West)
    
    count_y = movess!(r, Nord)
    o(r, Sud)
    count_x = movess!(r, Ost)
    o(r, West)
    for i in 1:count_y + 1
        for j in 1:count_x + 1
            if i % 2 == 0
                if (j % 2 == 1)
                    putmarker!(r)
                    if isborder(r, Ost) == false
                        move!(r, Ost)
                    end
                else
                    if isborder(r, Ost) == false
                        move!(r, Ost)
                    end
                end
            else
                if (j % 2 == 1)
                    
                    if isborder(r, Ost) == false
                        move!(r, Ost)
                    end
                else
                    putmarker!(r)
                    if isborder(r, Ost) == false
                        move!(r, Ost)
                    end
                end
            end
        end
        
        o(r, West)
        if isborder(r, Nord) == false
            move!(r, Nord)
        end

    end
    o(r, Sud)
    o(r, West)
    wer(r, Nord, count_x_home)
    wer(r, Ost, count_y_home)

end


