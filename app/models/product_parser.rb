class ProductParser
  @rows = [];

  def initialize(file_path)
    doc = File.open(file_path) { |f|
      Nokogiri::XML(f)
    }

    @rows = doc.xpath('//product')
  end

  def get_products
    p = @rows.first

    product_info = self.get_product_base_info(p)

    product_documents_list = get_product_documents(p)
    product_badges = get_product_badges(p)
    product_images = get_product_images(p)

    categories_tree_raw = self.get_categories_tree(p)
    category = get_product_category(categories_tree_raw)

    product_info[:category] = category
    product_info[:documents_list] = product_documents_list
    product_info[:badges] = product_badges
    product_info[:images] = product_images


    p = Product.new(product_info)
    p.save

    p
  end

  def get_product_images(product_node)
    images = []

    product_node.xpath("productimages/image").each {|img|
      images << {
        alt: img.attr('alttext'),
        src: img.text
      }
    }

    images
  end

  def get_product_badges(product_node)
    badges = []

    product_node.xpath("productbadges/badge").each {|badge|
      badgeimage = badge.xpath('badgeimage')
      badges << {
        image_src: badgeimage.text,
        image_alt: badgeimage.attr("alttext").text,
        name: badge.attr("name"),
        title: badge.attr("title")
      }
    }

    badges
  end

  def get_product_documents(product_node)
    docs = []
    product_node.xpath("productdocuments/document").each {|doc|
      docs << {
        name: doc.attr("name"),
        url: doc.text
      }
    }
    docs
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

    info[:name] = product_node.xpath("productinfo/name").text
    info[:url] = product_node.xpath("productinfo/url").text
    info[:modelnumber] = product_node.xpath("productinfo/modelnumber").text

    info[:description] = product_node.xpath("productinfo/productsections/section[@name='Detail']").text
    info[:features] = product_node.xpath("productinfo/productsections/section[@name='Key Features']").text
    info[:specifications] = product_node.xpath("productinfo/productsections/section[@name='SPECIFICATIONS']").text
    info[:documents] = product_node.xpath("productinfo/productsections/section[@name='Documents']").text


    info[:raw] = product_node.to_s
    info
  end

end
