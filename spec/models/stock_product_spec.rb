require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'Gera um numero de serie' do
    it 'ao Criar um StockProduct' do
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
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: 1.week.from_now, status: :delivered)
      
      product = ProductModel.create!(name: ' Cadeira gamer', weight: 5, height: 10, width: 80,
                                     depth: 80, sku: 'CGAMER-BOX-84373', supplier: supplier)

      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      #Assert
      expect(stock_product.serial_number.length).to eq 20
    end
    it 'e não é modificado' do
      #Arrange
      user = User.create!(name:'Thiago', email: 'thiago@email.com', password: 'password')

      warehouse = Warehouse.create!(name: 'Galpão do Santos', code: 'RIO', address: 'Endereço', 
                                    cep: '25000-000', city: 'Rio', area: 1000,
                                    description: 'Alguma descrição')

      other_warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GRU', address: 'Endereço', 
                                      cep: '45000-000', city: 'São Paulo', area: 80000,
                                      description: 'Galpão de SP')

      supplier = Supplier.create!(corporate_name: 'LG Tecnologia', brand_name: 'LG', 
                                  registration_number: '1548965325487', 
                                  full_address: 'Rua das tvs, 500', city: 'Rio de Janeiro',
                                  state: 'RJ', email: 'lg@tecnologia.com', 
                                  phone_number: '219548745236')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: 1.week.from_now, status: :delivered)
      
      product = ProductModel.create!(name: ' Cadeira gamer', weight: 5, height: 10, width: 80,
                                     depth: 80, sku: 'CGAMER-BOX-84373', supplier: supplier)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      original_serial_number = stock_product.serial_number
      #Act
      stock_product.update(warehouse: other_warehouse)

      #assert
      expect(stock_product.serial_number).to eq original_serial_number
    end
    end
end
