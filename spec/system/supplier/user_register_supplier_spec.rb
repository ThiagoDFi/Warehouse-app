require 'rails_helper'

describe 'Usuario cadastra um fornecedor' do
  it 'a partir da tela inicial' do 
    
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'

    #Assert
    expect(page).to have_field('Razão social')
    expect(page).to have_field('Nome fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Telefone')
  end

  it 'com sucesso' do

    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'
    fill_in 'Razão social', with: 'Tecnologia LTDA'
    fill_in 'Nome fantasia', with: 'Tecnologia'
    fill_in 'CNPJ', with: '7936779000130'
    fill_in 'Endereço', with: 'Rua das tulipas, 400'
    fill_in 'Cidade', with: 'Barueri'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'tecnologia@teste.com'
    fill_in 'Telefone', with: '11958745526'
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Tecnologia'
    expect(page).to have_content 'Barueri - SP'
    expect(page).to have_content 'Fornecedor cadastrado com sucesso!'
  end

  it 'com dados incompletos' do

    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'
    fill_in 'Razão social', with: ''
    fill_in 'Nome fantasia', with: ''
    fill_in 'Cidade', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Fornecedor não cadastrado.'
  end
end