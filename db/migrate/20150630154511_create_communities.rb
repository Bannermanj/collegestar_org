class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :type
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
