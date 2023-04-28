require 'rails_helper'

describe 'Usuário entra em um Fornecedor' do
  it 'e ve detalhes adicionais do fornecerdor' do

    #Arrange
    Supplier.create!(corporate_name: 'Grafite e Tinta', brand_name: 'Grafites', 
                      registration_number: '2154841023547', full_address: 'Rua das validações, 400', 
                      city: 'Barueri', state: 'SP', email: 'tinta@tecnologia.com', 
                      phone_number: '11987452361')

    #Assert
    visit root_path
    click_on 'Fornecedores'
    click_on 'Grafites'

    #Act
    expect(page).to have_content 'Razão social: Grafite e Tinta'
    expect(page).to have_content 'Grafites'
    expect(page).to have_content 'CNPJ: 2154841023547'
    expect(page).to have_content 'Endereço: Rua das validações, 400'
    expect(page).to have_content 'Cidade: Barueri'
    expect(page).to have_content 'Estado: SP'
    expect(page).to have_content 'E-mail: tinta@tecnologia.com'
    expect(page).to have_content 'Telefone: 11987452361'
  end

  it 'e volta a tela inicial' do

    #arrange
    Supplier.create!(corporate_name: 'Grafite e Tinta', brand_name: 'Grafites', 
                     registration_number: '2154841023547', full_address: 'Rua das validações, 400', 
                     city: 'Barueri', state: 'SP', email: 'tinta@tecnologia.com', 
                     phone_number: '11987452361')
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Grafites'
    click_on 'Voltar'

    #Assert
    expect(current_path). to eq root_path
  end
end