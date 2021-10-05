using HorizonSideRobots

function wer(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end

function wer_kraska(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
        putmarker!(r)
    end
end

function movess!(r::Robot, side::HorizonSide)
    counter = 0
    while isborder(r, side) == false
        counter += 1
        move!(r, side)
    end
    return counter
end

function idem_and_stavim_markers(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
    end
end



function piramida(r::Robot)

    S_co = movess!(r, Sud)
    W_co = movess!(r, West)
    weight_count = movess!(r, Nord)
    wer(r, Sud, weight_count)
    dolgetude_count = movess!(r, Ost)
    wer(r, West, dolgetude_count)
    println(weight_count,' ', dolgetude_count)

    go = dolgetude_count
    st = weight_count

    putmarker!(r)
    idem_and_stavim_markers(r, Ost)
    wer(r, West, dolgetude_count)
    while st > 0
        if isborder(r, Nord) == false
            move!(r, Nord)
        end
        putmarker!(r)
        go = go - 1
        wer_kraska(r, Ost, go)
        wer(r, West, go)
        st = st - 1
        
    end

    wer(r, Sud, weight_count)
    wer(r, Nord, S_co)
    wer(r, Ost, W_co )
end