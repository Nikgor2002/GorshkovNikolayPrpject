using HorizonSideRobots
include("7.jl")

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

function mov_st(r::Robot, side::HorizonSide)
    if isborder(r, side) == false
        move!(r, side)
    end
end


function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end   


function invr(fl::Any)
    if fl == true
        return false
    else
        return true
    end
end


function stroke_mode(r::Robot, N::Int, p_x::Int, bl::Bool)
    for i in 1:p_x
        
        if ( bl == true )
            putmarker!(r)
            if isborder(r, Ost) == false
                move!(r, Ost)
            else
                o(r, West)
                break
            end
        else
            if isborder(r, Ost) == false
                move!(r, Ost)
            else
                o(r, West)
                break
            end
        end
        if ( i != 1 && i % N == 0 )
            bl = invr(bl)
        end
    end
end

function Chak_mate(r::Robot, N::Int)
    if N == 1
        Chess(r::Robot)
    else
        bl = true
        y = movess!(r, Sud)
        x = movess!(r, West)
        p_x = movess!(r, Nord)
        o(r, Sud)
        p_y = movess!(r, Ost)
        o(r, West)
        for j in 1:p_y
            stroke_mode(r, N, p_x+2, bl)
            o(r, West)
            if isborder(r, Nord) == false
                move!(r, Nord)
            else
                o(r, Sud)
                break
            end
            if ( j != 1 && j % N == 0 )
                bl = invr(bl)
            end
        end
        wer(r, Nord, y)
        wer(r, Ost, x)
    end
end
                
