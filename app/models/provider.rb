class Provider < ActiveRecord::Base
  has_many :categories, class_name: "Category", foreign_key: "provider_id"
end
