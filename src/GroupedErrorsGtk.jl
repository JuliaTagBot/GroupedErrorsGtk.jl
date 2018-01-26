module GroupedErrorsGtk

using Gtk, JuliaDB, GroupedErrors, StatPlots

gr()

include("types.jl")
include("buildwindow.jl")
include("selectdata.jl")
include("plot.jl")

end
