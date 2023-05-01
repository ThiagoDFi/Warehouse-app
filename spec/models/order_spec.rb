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
                          estimated_delivery_date: '2023-10-01')
      #Act
      result = order.valid?

      #Assert
      expect(result).to be true
    end
    it 'data estimada de entrega deve ser obrigatoria' do

      #Arrange
      order = Order.new(estimated_delivery_date: '')

      #Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      #Assert
      expect(result).to be true
    end
    it 'data estimada de entrega não deve ser antiga' do
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)

      #Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      #Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include("Deve ser futura.")
    end
    it 'data estimada de entrega não ser igual a hoje' do
      #Arrange
      order = Order.new(estimated_delivery_date: Date.today)

      #Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      #Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include("Deve ser futura.")
    end
    it 'data estimada de entrega deve ser igual ou maior que amanhã' do
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      #Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      #Assert
      expect(result).to be false
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
                        estimated_delivery_date: '2023-10-01')

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
                                  estimated_delivery_date: '2023-10-01')

      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                               estimated_delivery_date: '2023-11-15')

      #Act
      second_order.save!

      #Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
