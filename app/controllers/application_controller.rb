
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def import
    #Category.delete_all
    #Product.delete_all
    #
    #parser = ProductParser.new "/home/mflafl/var1.xml", "Carrier"
    #parser = ProductParser.new "/home/mflafl/var2.xml", "Bryant"
    
    #res = parser.get_products
    provider = Provider.where(name: "Carrier").first
    res = provider.categories

    render :json => res
  end

end