class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def set_shopping_bag
      if logged_in?
        @shopping_bag = current_user.shopping_bag
      else
        if session[:shopping_bag]
          @shopping_bag = ShoppingBag.find(session[:shopping_bag])
        else
          @shopping_bag = ShoppingBag.create
          session[:shopping_bag] = @shopping_bag.id
        end
      end
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please login."
        redirect_to login_url
      end
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
