class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :modelnumber
      t.belongs_to :category

      t.string :name
      t.string :url
      t.integer :status
      t.text :raw
      t.timestamps null: false
    end
  end
end
