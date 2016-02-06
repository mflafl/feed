
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def import
    Product.delete_all

    parser = ProductParser.new "/home/mflafl/products.xml"
    res = parser.get_products

    render :json => res
  end

end