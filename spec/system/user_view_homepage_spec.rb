require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e ve o nome da app' do
    #Arrange

    #Act
    visit('/')

    #Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e ve os galpões cadastrados' do
    # Arrange
    # cadastrar 2 galpoes: Rio e Maceio
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de janeiro', area: 60_000)
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000)

    #Act
    visit('/')

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

    #act
    visit('/')

    #Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end