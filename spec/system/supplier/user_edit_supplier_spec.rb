require 'rails_helper'

describe 'Usuario edita um fornecedor' do
  it 'a partir da tela de detalhes' do

    #Arrange
    Supplier.create!(corporate_name: 'Samsung Electronics Company LTDA', brand_name: 'Samsung', 
                     registration_number: '2154847823547', full_address: 'Rua dos eletronicos, 1000', 
                     city: 'São Paulo', state: 'SP', email: 'samsung@tecnologia.com', 
                     phone_number: '11978451234')
    #Act
     visit root_path
     click_on 'Fornecedores'
     click_on 'Samsung'
     click_on 'Editar'
     
    #assert
    expect(page).to have_content 'Editar fornecedor'
    expect(page).to have_field 'Razão social', with: 'Samsung Electronics Company LTDA'
    expect(page).to have_field 'Nome fantasia', with: 'Samsung'
    expect(page).to have_field 'CNPJ', with: '2154847823547'
    expect(page).to have_field 'Endereço', with: 'Rua dos eletronicos, 1000'
    expect(page).to have_field 'Cidade', with: 'São Paulo'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'E-mail', with: 'samsung@tecnologia.com'
    expect(page).to have_field 'Telefone', with: '11978451234'
  end

  it 'com sucesso' do

    #Arrange
    Supplier.create!(corporate_name: 'Samsung Electronics Company LTDA', brand_name: 'Samsung', 
                     registration_number: '2154847823547', full_address: 'Rua dos eletronicos, 1000', 
                     city: 'São Paulo', state: 'SP', email: 'samsung@tecnologia.com', 
                     phone_number: '11978451234')
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Editar'
    fill_in 'Razão social', with: 'Apple company'
    fill_in 'Nome fantasia', with: 'Apple'
    fill_in 'CNPJ', with: '1478459874523'
    fill_in 'E-mail', with: 'apple@tecnologia.com'
    click_on 'Enviar'

    #Assert

    expect(page).to have_content 'Razão social: Apple company'
    expect(page).to have_content 'Apple'
    expect(page).to have_content 'CNPJ: 1478459874523'
    expect(page).to have_content 'Endereço: Rua dos eletronicos, 1000'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'Estado: SP'
    expect(page).to have_content 'E-mail: apple@tecnologia.com'
    expect(page).to have_content 'Telefone: 11978451234'
    expect(page).to have_content 'Fornecedor atualizado com sucesso!'
  end

  it 'e mantem os dados obrigatorios' do
    
    #Arrenge
    Supplier.create!(corporate_name: 'LG tecnologia', brand_name: 'LG', 
                     registration_number: '1548965325487', full_address: 'Rua das tvs, 500', 
                     city: 'Rio de Janeiro', state: 'RJ', email: 'lg@tecnologia.com', 
                     phone_number: '219548745236')

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'LG'
    click_on 'Editar'
    fill_in 'Razão social', with: ''
    fill_in 'Nome fantasia', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Não foi possivel atualizar o fornecedor'
  end
end