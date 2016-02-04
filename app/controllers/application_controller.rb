
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def import
    cat = Category.new

    doc = File.open("/home/mflafl/products.xml") { |f|
      Nokogiri::XML(f)
    }

    products = doc.xpath('//product')

    categories = [];

    products.each { |p|
      
      categories_raw = p.xpath("productinfo/category").text;
      current_categories = []

      categories_raw.split("-").each { |c|
        current_categories << c.strip! || c
      }

      categories << current_categories
      
    }

    render :json => categories
  end
end