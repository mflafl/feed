class ProductData < ActiveRecord::Migration
  def change
    add_column :products, :documents_list, :text
    add_column :products, :images, :text
    add_column :products, :badges, :text
    
    add_column :products, :is_obsolete, :boolean
    
    add_column :products, :description, :text
    add_column :products, :features, :text
    add_column :products, :specifications, :text
    add_column :products, :documents, :text
  end
end
