class Product < ActiveRecord::Base
    STATUS_ACTIVE = 1

    def initialize(attributes={})
        @status = STATUS_ACTIVE
        
        super
    end
    


    belongs_to :category, class_name: "Category"
end