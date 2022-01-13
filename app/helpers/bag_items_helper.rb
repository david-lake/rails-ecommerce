module BagItemsHelper

  def item_total
    if logged_in?
      current_user.shopping_bag.total
    elsif session[:shopping_bag]
      shopping_bag = ShoppingBag.find(session[:shopping_bag])
      shopping_bag.total
    else
      0.00
    end
  end
end
