
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def import
    #Product.delete_all
    #
    #parser = ProductParser.new "/home/mflafl/products.xml"
    #res = parser.get_products

    #user  = User.new(password: "12345678", email: "mflafl@ya.ru")
    #user.save!

    render :json => 't' #user
  end

end