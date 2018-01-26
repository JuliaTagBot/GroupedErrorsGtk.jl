buildwindow(df::AbstractString; nbox = 5) = buildwindow(loadtable(df); nbox = nbox)

function buildwindow(df::JuliaDB.AbstractIndexedTable; nbox = 5)
    unique_iter = ((key, union(column(df, key))) for key in colnames(df))
    cols = Tuple(ChecklistColumn(key, sort(val)) for (key, val) in unique_iter
        if length(val) < nbox)
    grid = GtkGrid()

    xs = PlotOptions(:x, colnames(df))
    ys = PlotOptions(:y, vcat(colnames(df), :hazard, :density, :cumulative))

    grid[1,1] = xs.button
    grid[2,1] = ys.button

    plotbutton = GtkButton("Press")

    grid[3,1] = plotbutton
    tmp1 = tempname()*".png"
    img = GtkImage(tmp1)
    function button_clicked_callback(widget)
        isfile(tmp1) && rm(tmp1)
        tmp1 = tempname()*".png"
        GroupedErrorsGtk.doplot(df, cols, getoption(xs), getoption(ys), tmp1)
        setproperty!(img, "file", tmp1)
    end
    signal_connect(button_clicked_callback, plotbutton, "clicked")

    for (ind, col) in enumerate(cols)
      grid[ind,2] = col.button
      for (i, item) in enumerate(col.items)
        grid[ind,i+2] = item.button
      end
    end

    setproperty!(grid, "column_homogeneous", false) # setproperty!(grid,:homogeoneous,true) for gtk2
    setproperty!(grid, "column_spacing", 15)  # introduce a 15-pixel gap between columns



    vbox = GtkBox(:v)

    push!(vbox, grid)
    push!(vbox, img)

    # Create a window and show everything
    win = GtkWindow("Select Data")
    push!(win, vbox)
    showall(win)
end
