class AddNameToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :name, :string
  end
end
