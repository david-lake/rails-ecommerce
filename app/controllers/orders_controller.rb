class OrdersController < ApplicationController
  before_action :set_shopping_bag, only: [:new, :create, :summary, :payment]
  before_action :logged_in_user
  before_action :admin_user, only: [:index, :update]
  before_action :correct_user, only: :show
  before_action :get_previous_addresses, only: [:new, :create]

  def index
    @orders = Order.where("status >= ?", "1").paginate(page: params[:page])
  end

  def order_history
    @orders = current_user.orders.where("status >= ?", "1").paginate(page: params[:page])
  end

  def show
    @order = Order.find(params[:id])
    redirect_to root_url if @order.status == 0
  end

  def new
    if @shopping_bag.bag_items.any?
      order_in_progress = current_user.orders.where(status: 0).first
      if order_in_progress
        redirect_to order_summary_url(order_in_progress)
      else
        @order = Order.new
        @order.shipping_address = Address.new
        @order.billing_address  = Address.new
      end
    else
      redirect_to root_url
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.shipping_address_id = params[:order][:shipping_address_id].to_i if params[:order][:shipping_address_id]
    if params[:same_billing_address] == '1'
      @order.billing_address = @order.shipping_address
    else
       @order.billing_address_id = params[:order][:billing_address_id].to_i if params[:order][:billing_address_id]
    end
    if @order.save
      redirect_to order_summary_url(@order)
    else
      render 'new'
    end
  end

  def summary
    @order = Order.find(params[:id])
    redirect_to root_url if @order.status > 0
  end

  def payment
    order = Order.find(params[:id])
    order.update_attributes(item_total: @shopping_bag.total,
                            postage: @shopping_bag.calculate_postage,
                            status: 1)
    @shopping_bag.bag_items.each do |item|
      order.order_items.create(product: item.product, quantity: item.quantity)
      item.product.update_stock(item.quantity)
      item.destroy
    end
    respond_to do |format|
      format.html { redirect_to order_confirmation_url(order) }
      format.js
    end
  end

  def confirmation
    @order = Order.find(params[:id])
    redirect_to root_url if @order.status != 1
    UserMailer.order_confirmation(current_user).deliver_now
    AdminMailer.new_order.deliver_now
    @order.update_attributes(status: 2)
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(status: 3)
    UserMailer.order_dispatched(@order.user).deliver_now
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.js
    end
  end

  private

    def order_params
      params.require(:order).permit(
        shipping_address_attributes: [ :user_id, :line_1, :line_2, :line_3,
                                       :town, :county, :postcode ],
        billing_address_attributes:  [ :user_id, :line_1, :line_2, :line_3,
                                       :town, :county, :postcode ]
      )
    end

    def correct_user
      order = Order.find(params[:id])
      redirect_to root_url unless current_user?(order.user) || current_user.admin?
    end

    def get_previous_addresses
     @shipping_addresses = current_user.orders.unscope(:order)
                                       .distinct.select(:shipping_address_id)
                                       .map { |x| x.shipping_address }
     @billing_addresses  = current_user.orders.unscope(:order)
                                       .distinct.select(:billing_address_id)
                                       .map { |x| x.billing_address }
    end
end
