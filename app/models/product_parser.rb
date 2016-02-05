
class ProductParser
  @rows = [];

  def initialize(file_path)
    doc = File.open(file_path) { |f|
      Nokogiri::XML(f)
    }

    @rows = doc.xpath('//product')
  end
  
  def get_categories_tree(product_node)
    categories_raw = product_node.xpath("productinfo/category").text;
    
    categories = []
    
    categories_raw.split("-").each { |c|
      categories << (c.strip! || c)
    }
    
    categories
  end
  
  def get_product_category(tree)
    parent_id = nil
    category = nil
    
    tree.each { |category_name|
      category = Category.where(name: category_name, parent_id: parent_id).first

      if !category
        category = Category.new(name: category_name, parent_id: parent_id)
        category.save
      end

      parent_id = category.id
    }

    category

  end
  
  def get_product_base_info(product_node)
    info = {}

    info[:name] = p.xpath("productinfo/name").text
    info[:url] = p.xpath("productinfo/url").text
    info[:modelnumber] = p.xpath("productinfo/modelnumber").text
    info[:raw] = p.to_s

    info
  end

  def get_products
    p = @rows.first

    product_info = self.get_product_base_info(p)

    categories_tree_raw = self.get_categories_tree(p)
    category = get_product_category(categories_tree_raw)

    product_info[:category] = category


    p = Product.new(product_info)
    p.save

    p
  end
end
