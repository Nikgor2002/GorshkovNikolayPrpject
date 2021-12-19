using HorizonSideRobots

function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end
#Имеем ввиду, что мы находимся в левом нижним углу
function go_count(r::Robot)
    cnt = 0
    cnt_bool = false
        while isborder(r, Ost) == false
            move!(r, Ost)
            if isborder(r, Nord) == true
                if cnt_bool == false
                    cnt += 1
                end
                cnt_bool = true
            else
                cnt_bool = false
            end
        end
    return cnt            
end

function movess!(r::Robot, side::HorizonSide)
    counter = 0
    while isborder(r, side) == false
        counter += 1
        move!(r, side)
    end
    return counter
end



function Horizontal_partitions(r::Robot)
    y = movess!(r, Nord)
    wer(r, Sud, y)
    rezult = 0
    for _ in 1:y
        rezult += go_count(r::Robot)
        movess!(r, West)
        move!(r, Nord)
    end
    return rezult
end