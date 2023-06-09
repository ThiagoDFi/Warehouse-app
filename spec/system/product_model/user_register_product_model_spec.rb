require 'rails_helper'

describe 'Usuario cadastra um modelo de produto' do
  it 'com sucesso' do

    #Arrenge
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'Samsung', 
                                corporate_name: 'Sansung Eletronicos LTDA',
                                registration_number: '5478412598745', 
                                full_address: 'Av dos testes, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br',
                                phone_number: 11954852036)
    other_supplier = Supplier.create!(brand_name: 'LG', 
                                corporate_name: 'LG do Brasil LTDA',
                                registration_number: '4784125485698', 
                                full_address: 'Av das empresas, 600', city: 'São Paulo', 
                                state: 'SP', email: 'contato@lg.com.br',
                                phone_number: 11954784125)

    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'Peso', with: '10_000'
    fill_in 'Altura', with: '60'
    fill_in 'Largura', with: '90'
    fill_in 'Comprimento', with: '10'
    fill_in 'SKU', with: 'TV40_SAMS-DTF456'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Modelo de produto cadsatrado com sucesso!'
    expect(page).to have_content 'TV 40 polegadas'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV40_SAMS-DTF456'
    expect(page).to have_content 'Dimensão: 60cm x 90cm x 10cm'
    expect(page).to have_content 'Peso: 10000g'
  end

  it 'deve preencher todos os campos' do
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'Samsung', 
                                corporate_name: 'Sansung Eletronicos LTDA',
                                registration_number: '5478412598745', 
                                full_address: 'Av dos testes, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br',
                                phone_number: 11954852036)
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Não foi possivel cadastrar o modelo de produto'
  end
end