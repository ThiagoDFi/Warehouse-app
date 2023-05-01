require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e ve o nome da app' do
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #Act
    login_as(user)
    visit(root_path)

    #Assert
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link('Galpões & Estoque', href: root_path)

  end

  it 'e ve os galpões cadastrados' do
    # Arrange
    # cadastrar 2 galpoes: Rio e Maceio
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de janeiro', area: 60_000,
                     address: 'Av do porto, 1000', cep: 20000-000, description: 'Galpão do rio')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                     address: 'Av Atlantica, 50', cep: 80000-000, description: 'Perto do Aeroporto')

    #Act
    login_as(user)
    visit(root_path)

    #Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    # garantir que eu vejo na tela os galpoes Rio e Maceio
    expect(page).to have_content('Rio')
    expect(page).to have_content('Codigo: SDU')
    expect(page).to have_content('Cidade: Rio de janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Codigo: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end

  it 'E não existem galpões cadastrados' do

    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    #act
    login_as(user)
    visit(root_path)

    #Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end