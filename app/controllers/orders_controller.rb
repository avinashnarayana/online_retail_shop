class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :shopkeeper,     only: [:edit, :update, :destroy]
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    if session.key?(:cart)
      ActiveRecord::Base.transaction do
      if logged_in?
        @order = current_user.orders.new(order_params) 
      else
        @order = Order.new(order_params, user_id: 1)
      end
      respond_to do |format|
        if @order.save
          format.html { 
            session[:cart].keys.each do |prod_id|
              t = @order.transactions.create(product_id: prod_id, quantity: session[:cart][prod_id])
              if !t.product.stocks.find_by(location_id:1).decrement!(:quantity, t.quantity.to_i) || !t.save
                flash[:danger] = "Error"
                raise ActiveRecord::Rollback
                redirect_to cart_path
              end
            end
            flash[:success] = 'Order was successfully created.'
            session.delete(:cart)
            redirect_to @order 
          }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:delivery_name, :delivery_address)
    end
end
