function buildwindow(df; nbox = 5)
    categoricals = filter(key -> length(union(df[key])) < nbox, names(df))
    cols = [ChecklistColumn(key, sort(union(df[key]))) for key in categoricals]
    grid = GtkGrid()
    
    for (ind, col) in enumerate(cols)
      grid[ind,1] = col.button
      for (i, item) in enumerate(col.items)
        grid[ind,i+1] = item.button
      end
    end

    # Create a window and show the grid there
    win = GtkWindow("Select Data")
    setproperty!(grid, "column_homogeneous", false) # setproperty!(grid,:homogeoneous,true) for gtk2
    setproperty!(grid, "column_spacing", 15)  # introduce a 15-pixel gap between columns
    push!(win, grid)
    showall(win)
end
    
