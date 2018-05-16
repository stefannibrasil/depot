class StoreController < ApplicationController
  include SessionCounter
  include CurrentCart
  before_action :set_counter
  before_action :set_cart
  skip_before_action :authorize

  def index
    @counter = session[:counter]
    @products = Product.order(:title)
  end
end
