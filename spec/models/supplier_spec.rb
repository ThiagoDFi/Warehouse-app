require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando Razão social está vazio' do
        #Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'Grafites', 
                                registration_number: '2154841023547', full_address: 'Rua das validações', 
                                city: 'Bareuri', state: 'SP', email: 'teste@tecnologia', 
                                phone_number: '11987452361')
        #Act
        result = supplier.valid?

        #Arrange
        expect(result).to eq false 
      end

      it 'falso quando Nome fantasia está vazio' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'Grafites e Tintas LTDA', brand_name: '', 
                                  registration_number: '2154841023547', full_address: 'Rua das validações', 
                                  city: 'Bareuri', state: 'SP', email: 'teste@tecnologia', 
                                  phone_number: '11987452361')
        #Act
        result = supplier.valid?

        #Arrange
        expect(result).to eq false 
      end

      it 'falso quando CNPJ está vazio' do
        #Arrange
        supplier = Supplier.new(corporate_name: 'Grafites e Tintas LTDA', brand_name: 'Grafites', 
                                  registration_number: '', full_address: 'Rua das validações', 
                                  city: 'Bareuri', state: 'SP', email: 'teste@tecnologia', 
                                  phone_number: '11987452361')
        #Act
        result = supplier.valid?

        #Arrange
        expect(result).to eq false 
      end
    end
      it 'falso quando código já está em uso' do
        #Arrange
        first_supplier = Supplier.create(corporate_name: 'Grafite e Tinta', brand_name: 'Grafites', 
                                          registration_number: '2154841023547', full_address: 'Rua das validações', 
                                          city: 'Bareuri', state: 'SP', email: 'teste@tecnologia.com', 
                                          phone_number: '11987452361')
        secound_supplier = Supplier.new(corporate_name: 'papeis e lápis', brand_name: 'Papelaria', 
                                        registration_number: '2154841023547', full_address: 'Rua das papelarias', 
                                        city: 'Osasco', state: 'SP', email: 'papelaria@pais.com', 
                                        phone_number: '11936541742')
        #Act
        result = secound_supplier.valid?

        #Assert
        expect(result).to eq false
      end
      it 'falso quando CNPJ não possui 13 numeros' do
        #Arrange
        supplier = Supplier.new(registration_number: '123456789012')
        #Act
        result = supplier.valid?

        #Assert
        expect(result).to eq false
      end
  end
end
