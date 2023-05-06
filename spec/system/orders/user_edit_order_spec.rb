require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
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


    #Act
    visit edit_order_path(order.id)

    #Assert
    expect(current_path).to eq new_user_session_path
  end
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
    Supplier.create!(corporate_name: 'Samsung Electronics Company LTDA', brand_name: 'Samsung', 
                                  registration_number: '2154847823547', full_address: 'Rua dos eletronicos, 1000', 
                                  city: 'São Paulo', state: 'SP', email: 'samsung@tecnologia.com', 
                                  phone_number: '11978451234')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now)

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '12/12/2023'
    select 'Samsung Electronics Company LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: Samsung Electronics Company LTDA'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2023'
  end
  it 'caso seja o responsavel' do
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
    visit edit_order_path(order.id)

    #Assert
    expect(current_path).to eq root_path
  end
end