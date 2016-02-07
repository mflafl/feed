class ProviderCategoriesAndProducts < ActiveRecord::Migration
  def change
    add_column :categories, :provider_id, :integer
    add_column :products, :provider_id, :integer
  end
end
