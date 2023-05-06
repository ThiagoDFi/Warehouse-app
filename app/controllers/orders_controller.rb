class OrdersController < ApplicationController

  before_action :set_order_check_user, only: [:show, :edit, :update, :delivered, :canceled]

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
   
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id,
                                                 :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
    redirect_to @order, notice: "Pedido registrado com sucesso."
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      render "new"
    end
  end

  def show
  end

  def index
    @orders = current_user.orders
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    @order = Order.find(params[:id])
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :user_id, 
                                                 :estimated_delivery_date)
      if @order.update(order_params)
        redirect_to order_path(params[:id]), notice: "Pedido atualizado com sucesso."
      else
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
        flash.now[:notice] = "Não foi possivel atualizar o pedido."
        render "edit"
      end                            
  end

  def search
    @code = params["query"]
    # @order = Order.find_by(code: params["query"])
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def delivered
    @order.delivered!
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private

  def set_order_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      flash[:notice] = "Você não possui acesso a este pedido."
      redirect_to root_path
    end
  end
end