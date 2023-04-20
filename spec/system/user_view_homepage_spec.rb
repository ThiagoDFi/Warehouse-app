require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e ve o nome da app' do
    #Arrange

    #Act
    visit('/')

    #Assert
    expect(page).to have_content('Galpões & Estoque')
  end
end