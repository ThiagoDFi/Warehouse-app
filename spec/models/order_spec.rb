require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
  it 'deve ter um código' do
    #Arrange
    user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Galpão do Santos', code: 'RIO', address: 'Endereço', 
                                    cep: '25000-000', city: 'Rio', area: 1000,
                                    description: 'Alguma descrição')

    supplier = Supplier.create!(corporate_name: 'LG Tecnologia', brand_name: 'LG', 
                                  registration_number: '1548965325487', 
                                  full_address: 'Rua das tvs, 500', city: 'Rio de Janeiro',
                                  state: 'RJ', email: 'lg@tecnologia.com', 
                                  phone_number: '219548745236')
    order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: '2022-10-01')
    #Act
    result = order.valid?

    #Assert
    expect(result).to be true
  end
end
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      #Arrange
      user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

      warehouse = Warehouse.create!(name: 'Galpão do Santos', code: 'RIO', address: 'Endereço', 
                                    cep: '25000-000', city: 'Rio', area: 1000,
                                    description: 'Alguma descrição')

      supplier = Supplier.create!(corporate_name: 'LG Tecnologia', brand_name: 'LG', 
                                  registration_number: '1548965325487', 
                                  full_address: 'Rua das tvs, 500', city: 'Rio de Janeiro',
                                  state: 'RJ', email: 'lg@tecnologia.com', 
                                  phone_number: '219548745236')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: '2022-10-01')

      #Act
      order.save!
      result = order.code

      #Assert
      expect(result).not_to be_empty 
      expect(result.length).to eq 8
    end
    it 'e o codigo é único' do
      #Arrange
      user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

      warehouse = Warehouse.create!(name: 'Galpão do Santos', code: 'RIO', address: 'Endereço', 
                                    cep: '25000-000', city: 'Rio', area: 1000,
                                    description: 'Alguma descrição')

      supplier = Supplier.create!(corporate_name: 'LG Tecnologia', brand_name: 'LG', 
                                  registration_number: '1548965325487', 
                                  full_address: 'Rua das tvs, 500', city: 'Rio de Janeiro',
                                  state: 'RJ', email: 'lg@tecnologia.com', 
                                  phone_number: '219548745236')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: '2022-10-01')

      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                               estimated_delivery_date: '2022-11-15')

      #Act
      second_order.save!

      #Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
