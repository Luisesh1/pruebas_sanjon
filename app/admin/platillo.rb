ActiveAdmin.register Platillo do

config.filters = false
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

permit_params :name, :price, :category_id,:map,:map_file_name,:group_id,:is_child ,ingredients_attributes: [:name,:stock]

index do
  column :name, label: "Nombre"
  column :price 
  column :category
  actions

end

form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Platillo" do
      f.input :name
      f.input :price
      f.input :map, :as => :file
      f.input :is_child ,label:"Para niño"
    end
    f.inputs "Ingredientes" do
      f.has_many :ingredients do |s|
          s.input :name, :collection => Ingrediente.all.map{ |car| [car.nombre, car.id] }
          s.input :stock 
      end
    end
    f.inputs "group" do
      f.input :group , :collection => Group.all.map{ |car| [car.name, car.id] }
    end
    f.inputs "Categoria" do
      f.input :category, :collection => Category.all.map{ |car| [car.name, car.id] }
    end
    f.actions
end
end
