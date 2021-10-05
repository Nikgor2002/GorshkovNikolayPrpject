using HorizonSideRobots

function movess!(r::Robot, side::HorizonSide)
    counter = 0
    while isborder(r, side) == false
        counter += 1
        move!(r, side)
    end
    return counter
end

function  inverse(side::HorizonSide)
    HorizonSide(mod(Int(side) + 2, 4))
end


function  Ugol_1(r::Robot, side1::HorizonSide, side2::HorizonSide)
    massX = []
    while isborder(r, side1) == false || isborder(r, side2) == false
        y = movess!(r, side1)
        y_ = [y, side1]
        push!(massX, y_)
        x = movess!(r, side2)
        x_ = [x, side2]
        push!(massX, x_)

        
    end
    putmarker!(r)
    return massX
end

function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end

function home(r::Robot, side1::HorizonSide, side2::HorizonSide)
    massX_2 = Ugol_1(r, side1, side2)
    
    
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

function home2(r::Robot)
    qw = size_Kvatro(r::Robot)
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



function mainee(r::Robot)
    home2(r::Robot)

    home(r::Robot, West, Sud)
    #Nord and West
    home(r::Robot, West, Nord)
    #Nord and Ost
    home(r::Robot, Ost, Nord)
    #Sud and Ost
    home(r::Robot, Ost, Sud)

end   

    



    