require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do

    #Arrange

    #Act
    visit root_path
    click_on 'Registrar Pedido'

    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do

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
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU | Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: LG Tecnologia'
    expect(page).to have_content 'Usuário Responsável: Thiago - thiago@email.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'Galpão Rio'
    expect(page).not_to have_content 'Samsung Electronics Company LTDA'
  end
end
