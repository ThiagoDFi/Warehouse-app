require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'a partir dos detalhes de um pedido' do

    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', 
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de janeiro', area: 60_000,
                                  address: 'Av do porto, 1000', cep: 20000-000, description: 'Galpão do rio')
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
                                estimated_delivery_date: '2023-10-01')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    #Act
    login_as(user)
    visit root_path
    click_on 'Pedidos'
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '09/10/2023'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: LG Tecnologia'
    expect(page).to have_content 'Usuário Responsável: Thiago - thiago@email.com'
    expect(page).to have_content 'Data Prevista de Entrega: 09/10/2023'
  end

  it 'e os dados são obrigatorios' do
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', 
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de janeiro', area: 60_000,
                                  address: 'Av do porto, 1000', cep: 20000-000, description: 'Galpão do rio')
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
                                estimated_delivery_date: '2023-10-01')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    #Act
    login_as(user)
    visit root_path
    click_on 'Pedidos'
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: ''
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possivel atualizar o pedido.' 
  end

  it 'sendo responsavel pelo Pedido' do
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    second_user = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', 
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de janeiro', area: 60_000,
                                  address: 'Av do porto, 1000', cep: 20000-000, description: 'Galpão do rio')
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
                                estimated_delivery_date: '2023-10-01')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    #Act
    login_as(user)
    visit root_path
    click_on 'Pedidos'
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: 1.day.from_now
    click_on 'Gravar'

    #Assert
    expect(user).to eq(order.user)
  end
  it 'não sendo responsavel pelo pedido' do
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')
    second_user = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', 
                                  area: 100_000, address: 'Avenida do Aeroporto, 1000', 
                                  cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')
    Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de janeiro', area: 60_000,
                                  address: 'Av do porto, 1000', cep: 20000-000, description: 'Galpão do rio')
    supplier = Supplier.create!(corporate_name: 'LG Tecnologia', brand_name: 'LG', 
                                registration_number: '1548965325487', 
                                full_address: 'Rua das tvs, 500', city: 'Rio de Janeiro',
                                state: 'RJ', email: 'lg@tecnologia.com', 
                                phone_number: '219548745236')
    Supplier.create!(corporate_name: 'Samsung Electronics Company LTDA', brand_name: 'Samsung', 
                                registration_number: '2154847823547', full_address: 'Rua dos eletronicos, 1000', 
                                city: 'São Paulo', state: 'SP', email: 'samsung@tecnologia.com', 
                                phone_number: '11978451234')

    order = Order.create!(user: second_user, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: '2023-10-01')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    #Act
    login_as(user)
    visit root_path
    click_on 'Pedidos'
    click_on 'Aeroporto SP'
    click_on 'Editar'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Você não tem permissão para editar este pedido."
  end
end