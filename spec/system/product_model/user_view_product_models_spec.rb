require 'rails_helper'

describe 'Usuario ve modelos de produtos' do
  it 'se estiver autentificado' do
    #Arrange

    #Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'a partir do menu' do
  
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #Act
    login_as(user)
    visit root_path
    within('nav') do
    click_on 'Modelos de Produtos'
    end
    #Asssert
    expect(current_path).to eq product_models_path
  end

  it 'e com sucesso' do

    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    supplier = Supplier.create!(brand_name: 'Samsung', 
                                corporate_name: 'Sansung Eletronicos LTDA',
                                registration_number: '5478412598745', 
                                full_address: 'Av dos testes, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br',
                                phone_number: 11954852036)

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, 
                        depth: 10, sku: 'TV32-SAMSU-XYAS84', supplier: supplier)
    ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width: 80, 
                         height: 15, depth: 20, sku: 'SOU71-SAMSU-PAD845', 
                         supplier: supplier)
    #Act
    login_as(user)
    visit root_path
    within('nav') do
    click_on 'Modelos de Produtos'
    end

    #Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XYAS84'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Soundbar 7.1 Surround'
    expect(page).to have_content 'SOU71-SAMSU-PAD845'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'

    #Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
  end
end