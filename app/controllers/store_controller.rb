class StoreController < ApplicationController
  include SessionCounter
  before_action :set_counter

  def index
    @counter =  session[:counter]
    @products = Product.order(:title)
  end
end
