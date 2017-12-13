mutable struct ChecklistItem{T}
    value::T
    button::GtkCheckButton
end

ChecklistItem(value) = ChecklistItem(value, GtkCheckButton(string(value), active = true))

isselected(item::ChecklistItem) = getproperty(item.button, "active", Bool)

mutable struct ChecklistColumn{T}
  button::GtkToggleButton
  items::Vector{ChecklistItem{T}}
end

ChecklistColumn(name::Symbol, values::AbstractVector{T}) where {T} = 
    ChecklistColumn(GtkToggleButton(string(name)), ChecklistItem.(values))

selecteditems(col::ChecklistColumn) = [i.value for i in col.items if isselected(i)]