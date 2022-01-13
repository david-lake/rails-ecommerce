class ShoppingBagsController < ApplicationController
  before_action :set_shopping_bag, only: :show

  def show
    @bag_items = @shopping_bag.bag_items
    @order     = Order.new
    unless @shopping_bag.enough_stock?
      msg  = "Sorry one or more items no longer has enough available stock. "
      msg += "Please update or remove items highlighted in red."
      flash.now[:danger] = msg
    end
  end
end
