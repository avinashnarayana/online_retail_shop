class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  end

  def create
    if params[:mobile].present? && params[:mobile]='android'
      render json: {
        error: "No such user; check the submitted email address",
        status: 400
      }
    end
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      
      log_in user
      redirect_back_or user
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
      session[:cart][:params[:id]]=quantity
      flash.now[:success] = 'Successfully added to cart'
    else
      flash.now[:danger] = 'Error'
    end
    redirect_to product
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
