class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.string :modelnumber
      t.integer :status
      t.belongs_to :category
      t.text :raw
      t.timestamps null: false
    end
  end
end
