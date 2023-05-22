require 'rails_helper'

describe 'Usuario ve o estoque' do
  it 'na tela do galpão' do
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')
    
    w = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                         address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                         description: 'Galpão destinado para cargas internacionais')
    
    supplier = Supplier.create!(brand_name: 'Samsung', 
                         corporate_name: 'Sansung Eletronicos LTDA',
                         registration_number: '5478412598745', 
                         full_address: 'Av dos testes, 1000', city: 'São Paulo', 
                         state: 'SP', email: 'sac@samsung.com.br',
                         phone_number: 11954852036)
    order = Order.create!(user: user, supplier: supplier, warehouse: w, estimated_delivery_date: 1.day.from_now)
    tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, 
                              depth: 10, sku: 'TV32-SAMSU-XYAS84', supplier: supplier)
    soundbar = ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width: 80, 
                                    height: 15, depth: 20, sku: 'SOU71-SAMSU-PAD845', 
                                    supplier: supplier)

    notebook = ProductModel.create!(name: 'Notebook Samsung ', weight: 2000, width: 40, 
                                    height: 9, depth: 20, sku: 'NOTEI5-SAMSU-SDH43', 
                                    supplier: supplier)

    3.times { StockProduct.create!(order: order, warehouse: w, product_model: tv)}
    4.times { StockProduct.create!(order: order, warehouse: w, product_model: notebook)}
    #Act
    login_as(user)
    visit root_path
    click_on w.name


    #Assert
    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content "3 x #{tv.sku}"
    expect(page).to have_content "4 x #{notebook.sku}"
    expect(page).not_to have_content "#{soundbar.sku}"
  end
end