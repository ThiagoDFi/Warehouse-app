require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do 
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

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight:10, width: 10, height:20,
                                     depth:50, supplier: supplier, sku: 'PRODUTO-A')
    product_b = ProductModel.create!(name: 'Produto B', weight:20, width: 20, height:20,
                                     depth:30, supplier: supplier, sku: 'PRODUTO-B')

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adcionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'
    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso.'
    expect(page).to have_content  '8 x Produto A'
  end
  it 'e não ve produtos de outro fornecedor' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password:'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', 
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    
    supplier_a = Supplier.create!(corporate_name: 'LG Tecnologia', brand_name: 'LG', 
                                  registration_number: '1548965325487', 
                                  full_address: 'Rua das tvs, 500', city: 'Rio de Janeiro',
                                  state: 'RJ', email: 'lg@tecnologia.com', 
                                  phone_number: '219548745236')
    supplier_b = Supplier.create!(corporate_name: 'Grafite e Tinta', brand_name: 'Grafites', 
                                  registration_number: '2154841023547', full_address: 'Rua das validações, 400', 
                                  city: 'Barueri', state: 'SP', email: 'tinta@tecnologia.com', 
                                  phone_number: '11987452361')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, 
                          estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight:10, width: 10, height:20,
                                     depth:50, supplier: supplier_a, sku: 'PRODUTO-A')
    product_b = ProductModel.create!(name: 'Produto B', weight:20, width: 20, height:20,
                                     depth:30, supplier: supplier_b, sku: 'PRODUTO-B')

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adcionar Item'


    #Assert
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end