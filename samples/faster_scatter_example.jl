using Base.Graphics
using Cairo
using Tk


function example(num::Integer)
    x = 100*rand(num)
    y = 100*rand(num)
    win = Toplevel("Scatter",800,600)
    c = Canvas(win, 800,600)
    pack(c,expand=true,fill="both")

    function update(c)
        ctx = getgc(c)
        set_coords(ctx,0,0,Tk.width(c),Tk.height(c),0,100,0,100)
        set_source_rgb(ctx,1,1,1)
        paint(ctx)

        r = 2.0
        lw = 1.0
        cc = r + (lw+1)/2 + 1
        rectangle(ctx, 0,0,2*cc,2*cc)
        clip(ctx)
        push_group(ctx)

        set_line_width(ctx,4)
        set_source_rgb(ctx,1,0,0)
        arc(ctx,cc,cc,cc,0,2*pi)
        stroke_preserve(ctx)
        set_source_rgb(ctx,1,1,1)
        fill(ctx) 
        p = pop_group(ctx)
        reset_clip(ctx)
        for i=1:num
            save(ctx)
            translate(ctx,x[i]-cc,y[i]-cc)
            set_source(ctx,p)
            paint(ctx)
            restore(ctx)
        end
        reveal(c)
        Tk.update()
    end
    c.resize = c->update(c)
end

