class WarehousesController < ApplicationController

  def show

    @warehouse = Warehouse.find(params[:id])
  end

  def new
    
  end 

  def create
  # Recebe os dados enviados
  # Cria um novo galpão no banco de dados
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description,
                                                       :address, :cep, :area)
    w = Warehouse.new(warehouse_params)
    w.save()

  #Redireciona par a tela inicial

    flash[:notice] = "Galpão cadastrado com sucesso!"
    redirect_to root_path
  end
end