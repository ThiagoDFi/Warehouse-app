require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do

    #Arrenge
    w = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', area: 40_000,
    address: 'Avenida colorida, 1500', cep: '56000-000',
    description: 'Galpão no centro do país')

    #Act
    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiaba'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga outros galpões' do
    #Arrenge
    first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', area: 40_000,
                                        address: 'Avenida colorida, 1500', cep: '56000-000',
                                        description: 'Galpão no centro do país')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 60_000,
                                        address: 'Avenida dos mineiros, 1500', cep: '46000-000',
                                        description: 'Galpão para cargas mineiras')
    #Act
    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiaba'
  end
end 