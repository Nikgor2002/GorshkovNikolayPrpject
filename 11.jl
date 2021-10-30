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
        counter2 = 0
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
                counter2 += 1
                move!(r, Nord)
            end
            
            move!(r, West)
            while isborder(r, Sud) == true
                move!(r, West)
            end
            wer(r, Sud, counter2)
            

           
        end
    end
    if side == West
        counter = 0
        counter2 = 0
        if isborder(r, West) == false
            move!(r, West)
            putmarker!(r)
            move!(r, Ost)
        else
            while isborder(r, West) == true
                counter += 1
                move!(r, Sud)
            end
            
            move!(r, West)
            while isborder(r, Nord) == true
                move!(r, West)
            end
            wer(r, Nord, counter)
            putmarker!(r)
            while isborder(r, Ost) == true
                counter2 += 1
                move!(r, Nord)
            end
            
            move!(r, Ost)
            while isborder(r, Sud) == true
                move!(r, Ost)
            end
            wer(r, Sud, counter2)
            

           
        end
    end
    if side == Nord
        counter = 0
        counter2 = 0
        if isborder(r, Nord) == false
            move!(r, Nord)
            putmarker!(r)
            move!(r, Sud)
        else
            while isborder(r, Nord) == true
                counter += 1
                move!(r, West)
            end
            
            move!(r, Nord)
            while isborder(r, Ost) == true
                move!(r, Nord)
            end
            wer(r, Ost, counter)
            putmarker!(r)
            while isborder(r, Sud) == true
                counter2 += 1
                move!(r, Ost)
            end
            
            move!(r, Sud)
            while isborder(r, West) == true
                move!(r, Sud)
            end
            wer(r, West, counter2)
            

        end
    end
    if side == Sud
        counter = 0
        counter2 = 0
        if isborder(r, Sud) == false
            move!(r, Sud)
            putmarker!(r)
            move!(r, Nord)
        else
            while isborder(r, Sud) == true
                counter += 1
                move!(r, West)
            end
            
            move!(r, Sud)
            while isborder(r, Ost) == true
                move!(r, Sud)
            end
            wer(r, Ost, counter)
            putmarker!(r)
            while isborder(r, Nord) == true
                counter2 += 1
                move!(r, Ost)
            end
            
            move!(r, Nord)
            while isborder(r, West) == true
                move!(r, Nord)
            end
            wer(r, West, counter2)
            

           
        end
    end
end

function myfun(r::Robot)
    if isborder(r, West)==true && isborder(r, Sud)==true
        move!(r, Nord)
        putmarker!(r)
        move!(r, Sud)
        move!(r, Ost)
        putmarker!(r)
        move!(r, West)
        return 0
    end
    if isborder(r, West)==true && isborder(r, Nord)==true
        move!(r, Sud)
        putmarker!(r)
        move!(r, Nord)
        move!(r, Ost)
        putmarker!(r)
        move!(r, West)
        return 0
    end
    if isborder(r, Ost)==true && isborder(r, Sud)==true
        move!(r, Nord)
        putmarker!(r)
        move!(r, Sud)
        move!(r, West)
        putmarker!(r)
        move!(r, Ost)
        return 0
    end
    if isborder(r, Ost)==true && isborder(r, Nord)==true
        move!(r, Sud)
        putmarker!(r)
        move!(r, Nord)
        move!(r, West)
        putmarker!(r)
        move!(r, Ost)
        return 0
    end
    colco(r, Ost)
    colco(r, West)
    colco(r, Nord)
    colco(r, Sud)
end

