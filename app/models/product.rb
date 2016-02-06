class Product < ActiveRecord::Base
    STATUS_INACTIVE = 0
    STATUS_ACTIVE = 1
    
    serialize :documents_list
    serialize :images
    serialize :badges

    def initialize(attributes={})
        @status = STATUS_ACTIVE
        
        super
    end
    


    belongs_to :category, class_name: "Category"
end