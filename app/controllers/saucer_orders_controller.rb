class SaucerOrdersController < ApplicationController
  before_action :set_saucer_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order, only: [:create,:new]

  # GET /saucer_orders
  # GET /saucer_orders.json
  def index
    @saucer_orders = SaucerOrder.all
  end

  # GET /saucer_orders/1
  # GET /saucer_orders/1.json
  def show
  end

  # GET /saucer_orders/new
  def new
    @saucer_order = SaucerOrder.new
  end

  # GET /saucer_orders/1/edit
  def edit
  end

  # POST /saucer_orders
  # POST /saucer_orders.json
  def create
    @saucer_order = SaucerOrder.new(saucer_order_params)
    @saucer_order.price = @saucer_order.platillo.price.to_f
    @saucer_order.order_id = @order.id
    respond_to do |format|
      if @saucer_order.save
        format.html { redirect_to @saucer_order, notice: 'Saucer order was successfully created.' }
        format.json { render :show, status: :created, location: @saucer_order }
      else
        format.html { render :new }
        format.json { render json: @saucer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saucer_orders/1
  # PATCH/PUT /saucer_orders/1.json
  def update
    respond_to do |format|
      if @saucer_order.update(saucer_order_params)
        format.html { redirect_to @saucer_order, notice: 'Saucer order was successfully updated.' }
        format.json { render :show, status: :ok, location: @saucer_order }
      else
        format.html { render :edit }
        format.json { render json: @saucer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saucer_orders/1
  # DELETE /saucer_orders/1.json
  def destroy
    
    order=@saucer_order.order
    if order.status==2
      redirect_to pay_path(order)
    else  
      @saucer_order.destroy
      respond_to do |format|
        format.html { redirect_to pay_path(order), notice: 'Saucer order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saucer_order
      @saucer_order = SaucerOrder.find(params[:id])
    end
    def set_order
      @order = Order.find(params[:order_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def saucer_order_params
      params.require(:saucer_order).permit(:platillo_id,:notes,:status,:quantity)
    end
end
