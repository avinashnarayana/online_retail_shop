class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]
  before_action :shopassistant
  # GET /transfers
  # GET /transfers.json
  def index
    @transfers = Transfer.all
  end

  # GET /transfers/1
  # GET /transfers/1.json
  def show
  end

  # GET /transfers/new
  def new
    if params.has_key?(:barcode)
      product = Product.find_by(barcode:params[:barcode])
      if(product)
        @transfer = product.transfers.build
      else
        flash[:danger] = "Product does not exist"
        redirect_to new_product_path, barcode: params[:barcode]
      end
    else
      @transfer = Transfer.new()
    end
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers
  # POST /transfers.json
  def create
    ActiveRecord::Base.transaction do
      @transfer = current_user.transfers.new(transfer_params)
      from_stock = Stock.create_with(quantity:0).find_or_create_by!(location_id:@transfer.from_location_id, product_id:@transfer.product_id)
      to_stock = Stock.create_with(quantity:0).find_or_create_by!(location_id:@transfer.to_location_id, product_id:@transfer.product_id)
      if(from_stock.location_id!=3 && from_stock.quantity < @transfer.quantity)
        flash[:danger]="Not Enough Stock"
        render :new and return
      end
      from_stock.decrement!(:quantity, @transfer.quantity.to_i) if(from_stock.location_id!=3)
      to_stock.increment!(:quantity, @transfer.quantity.to_i)
      respond_to do |format|
        if @transfer.save
          format.html { redirect_to @transfer, notice: 'Transfer was successfully created.' }
          format.json { render :show, status: :created, location: @transfer }
        else
          format.html { render :new }
          format.json { render json: @transfer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /transfers/1
  # PATCH/PUT /transfers/1.json
  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to @transfer, notice: 'Transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.json
  def destroy
    @transfer.destroy
    respond_to do |format|
      format.html { redirect_to transfers_url, notice: 'Transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfer).permit(:from_location_id, :to_location_id,:product_id, :quantity, :details)
    end
end
