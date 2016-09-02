class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      
      log_in user
      redirect_back_or products_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
  
  def add_to_cart
    product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    if product && quantity > 0
      session[:cart] ||= Hash.new(0)
      #if session[:cart].key?(params[:id])
       # session[:cart].delete(params[:id])
      #end
      session[:cart][params[:id]]=quantity
      flash[:success] = 'Successfully added to cart'+session[:cart].to_s
    else
      flash[:danger] = 'Error'
    end
    redirect_to product
  end
  def show_cart
    @cart = Hash.new(0)
    if session.key?(:cart)
      session[:cart].keys.each do |product_id|
        @cart[Product.find_by(id: product_id)]= session[:cart][product_id]
      end
    end
    @order = current_user.orders.build if logged_in?
    @order = Order.new
  end
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
