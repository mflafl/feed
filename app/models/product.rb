class Product < ActiveRecord::Base
    belongs_to :category, class_name: "Category"
end
