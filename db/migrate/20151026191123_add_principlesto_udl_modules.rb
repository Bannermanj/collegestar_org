class AddPrinciplestoUdlModules < ActiveRecord::Migration
  def change
    remove_column :udl_modules, :udl_principles, :string
    add_column :udl_modules, :udl_representation, :boolean
    add_column :udl_modules, :udl_action_expression, :boolean
    add_column :udl_modules, :udl_engagement, :boolean
  end
end
