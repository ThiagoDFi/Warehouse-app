require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do

    #Arrange
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
    
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira gamer', weight: 5,
                                   height: 700, width: 70, depth: 75, sku: 'CAD-GAMER-12345')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now, status: :pending)
    
    OrderItem.create!(order: order, product_model: product, quantity: 5)
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'


    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content "Situação do Pedido: Entregue"
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: product, warehouse: warehouse).count
    expect(estoque).to eq 5
  end
  it 'e pedido foi cancelado' do
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
    
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira gamer', weight: 5,
                                  height: 700, width: 70, depth: 75, sku: 'CAD-GAMER-12345')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now, status: :pending)
    
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
    expect(StockProduct.count).to eq 0
  end
end