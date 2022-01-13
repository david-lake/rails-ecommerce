class BagItemsController < ApplicationController
  before_action :set_shopping_bag, only: :create

  def create
    product = Product.find(params[:product_id])
    bag_item = @shopping_bag.add_product(product, bag_item_params)
    if bag_item.quantity > product.quantity
      flash[:danger] = "Not enough available stock. You may already have this item in your shopping bag."
    else
      if bag_item.save
        flash[:success] = "Item has been added to your bag"
      else
        flash[:danger] = "Sorry there was an issue adding this item"
      end
    end
    redirect_to product
  end

  def update
    @bag_item = BagItem.find(params[:id])
    if params[:bag_item][:quantity].to_i > @bag_item.product.quantity
      flash[:danger] = "Not enough available stock"
    else
      if @bag_item.update_attributes(bag_item_params)
        flash[:success] = "Item quantity has been updated"
      else
        flash[:danger] = "There was an issue"
      end
    end
    redirect_to shopping_bag_url
  end

  def destroy
    item = BagItem.find(params[:id])
    if item.destroy
      flash[:success] = "Item has been removed from your bag"
    else
      flash[:danger] = "Sorry there was an issue trying to remove item"
    end
    redirect_to shopping_bag_url
  end

  private

    def bag_item_params
      params.require(:bag_item).permit(:quantity)
    end
end
