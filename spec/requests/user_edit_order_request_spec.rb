require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
    #Arrange
    thiago = User.create!(name: 'Thiago', email: 'thiago@email.com', password:'password')

    user = User.create!(name: 'Joao', email: 'joao@email.com', password:'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', 
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    
    supplier = Supplier.create!(corporate_name: 'LG Tecnologia', brand_name: 'LG', 
                                  registration_number: '1548965325487', 
                                  full_address: 'Rua das tvs, 500', city: 'Rio de Janeiro',
                                  state: 'RJ', email: 'lg@tecnologia.com', 
                                  phone_number: '219548745236')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now)
    #Act
    login_as(thiago)
    patch(order_path(order.id), params: {order: { supplier_id: 3}})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end