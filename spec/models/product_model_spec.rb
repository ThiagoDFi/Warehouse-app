require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'nome é obrigatorio' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', 
                                corporate_name: 'Sansung Eletronicos LTDA',
                                registration_number: '5478412598745', 
                                full_address: 'Av dos testes, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br',
                                phone_number: 11954852036)
      pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, 
                                depth: 10, sku: 'TV32-SAMSU-XYAS84', supplier: supplier)
      #Act
      result = pm.valid?

      #Assert
      expect(result).to eq false
    end
    it 'sku é obrigatorio' do
      #Arrange
      supplier = Supplier.create!(brand_name: 'Samsung', 
                                corporate_name: 'Sansung Eletronicos LTDA',
                                registration_number: '5478412598745', 
                                full_address: 'Av dos testes, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br',
                                phone_number: 11954852036)
      pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, 
                                depth: 10, sku: '', supplier: supplier)
      #Act
      result = pm.valid?

      #Assert
      expect(result).to eq false
    end
  end
  describe '#dimension' do
    it 'exibe a dimensão do produto' do
      p = ProductModel.new(width: 70, height: 45, depth: 10)

      result = p.dimension

      expect(result).to eq('45cm x 70cm x 10cm')
    end
  end
end
