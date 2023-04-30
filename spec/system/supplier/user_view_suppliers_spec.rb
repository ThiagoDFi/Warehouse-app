require 'rails_helper'

describe 'Usuário visita fornecedores ' do
  it 'e ve a pagina de fornecedores' do

    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'

    #Assert
    expect(page).to have_content 'Fornecedores'
  end

  it 'e ve fornecedores cadastrados' do 

    #Arrenge
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')
    Supplier.create!(corporate_name: 'TDF LTDA', brand_name: 'TDF', registration_number: '1215478459632',
                      full_address: 'rua do teste, 100', city: 'Barueri', state: 'SP',
                      email: 'thiagoteste@gmail.com', phone_number: 11987452587)
    Supplier.create!(corporate_name: 'Centauro esportes', brand_name: 'Centauro', registration_number: '9874514784578',
                      full_address: 'rua dos atletas, 800', city: 'Rio de Janeiro', state: 'RJ',
                      email: 'centauroteste@gmail.com', phone_number: 21996541258)

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'

    #Assert
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'TDF'
    expect(page).to have_content 'Barueri - SP'
    expect(page).to have_content 'Centauro'
    expect(page).to have_content 'Rio de Janeiro - RJ'
  end

  it 'e não existe fornecedor cadastrado' do

    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'

    #Assert
    expect(page).to have_content 'Não existe nenhum fornecedor cadastrado'
  end

  it 'e volta para a home page' do

  #Arrange
  user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

  #Act
  login_as(user)
  visit root_path
  click_on 'Fornecedores'
  click_on 'Voltar'

  #Assert
  expect(current_path).to eq(root_path)
  end
end