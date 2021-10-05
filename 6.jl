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

function size_Kvatro(r::Robot)
    massX = []
    while isborder(r, West) == false || isborder(r, Sud) == false
        y = movess!(r, West)
        y_ = [y, West]
        push!(massX, y_)
        x = movess!(r, Sud)
        x_ = [x, Sud]
        push!(massX, x_)

        
    end
    count_y = movess!(r, Nord)
    wer(r, Sud, count_y)
    count_x = movess!(r, Ost)
    wer(r, West, count_x)
    h = [massX, count_x, count_y]
    return h
end

function perimetr1(r::Robot)
    while isborder(r::Robot, Ost) == true
        putmarker!(r)
        move!(r, Sud)
    end
    putmarker!(r)
    move!(r, Ost)
    while isborder(r::Robot, Nord) == true
        putmarker!(r)
        move!(r, Ost)
    end
    putmarker!(r)
    move!(r, Nord)
    while isborder(r::Robot, West) == true
        putmarker!(r)
        move!(r, Nord)
    end
    putmarker!(r)
    move!(r, West)
    while isborder(r::Robot, Sud) == true
        putmarker!(r)
        move!(r, West)
    end
    putmarker!(r)
    move!(r, Sud)
    while isborder(r::Robot, Ost) == true && ismarker(r::Robot) == false
        putmarker!(r)
        move!(r, Sud)
    end
    o(r, Sud)
    o(r, West)
    
end


function perimetr2(r::Robot)
    while isborder(r::Robot, West) == true
        putmarker!(r)
        move!(r, Nord)
    end
    putmarker!(r)
    move!(r, West)
    while isborder(r::Robot, Sud) == true
        putmarker!(r)
        move!(r, West)
    end
    putmarker!(r)
    move!(r, Sud)
    while isborder(r::Robot, Ost) == true
        putmarker!(r)
        move!(r, Sud)
    end
    putmarker!(r)
    move!(r, Ost)
    while isborder(r::Robot, Nord) == true
        putmarker!(r)
        move!(r, Ost)
    end
    putmarker!(r)
    move!(r, Sud)
    while isborder(r::Robot, West) == true && ismarker(r::Robot) == false
        putmarker!(r)
        move!(r, Nord)
    end
    o(r, Sud)
    o(r, West)
end

function perebor_kletok(r::Robot)
    qw = size_Kvatro(r::Robot)
    count_x = qw[2]
    count_y = qw[3]
    fors::Bool = false
    move!(r, Nord)
    for i in 1:count_y-1
        for _ in 1:count_x
            if isborder(r, Sud) == false
                if isborder(r, Ost) == false
                    move!(r, Ost)
                
                else
                    perimetr1(r::Robot)
                    fors = true
                    break
                end
            else
                break
            end

        end
        if fors == true
            break
        end
        if isborder(r, Sud) == false

            move!(r, Nord)
            for _ in 1:count_x
                if isborder(r, West) == false
                    move!(r, West)
                else
                    perimetr2(r::Robot)
                    fors = true
                    break
                end
            end
            if fors == true
                break
            end
            move!(r, Nord)

        else
            break
        end
    end

    massX_2 = qw[1]
    massX_2 = reverse!(massX_2)
    for i in 1:length(massX_2)
        fcope = massX_2[i]
        fcope[2] = inverse(fcope[2])
        if fcope[2] == West && fcope[2] == Ost
            wer(r, fcope[2], fcope[1])
        else
            wer(r, fcope[2], fcope[1])
            
        end
    end


end



    
