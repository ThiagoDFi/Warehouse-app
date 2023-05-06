require 'rails_helper'

describe 'Usuário ve seus próprios pedidos' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_path
    click_on 'Meus Pedidos'

    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'e não ve outros pedidos' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password:'password')
    other_user = User.create!(name: 'Thiago', email: 'thiago@email.com', password:'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', 
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    
    supplier = Supplier.create!(corporate_name: 'LG Tecnologia', brand_name: 'LG', 
                                  registration_number: '1548965325487', 
                                  full_address: 'Rua das tvs, 500', city: 'Rio de Janeiro',
                                  state: 'RJ', email: 'lg@tecnologia.com', 
                                  phone_number: '219548745236')

    first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now)

    second_order = Order.create!(user: other_user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now)

    third_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.week.from_now)

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'

    #Assert
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
  end
end