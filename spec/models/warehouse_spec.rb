require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando nome está vazio' do
        #Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', 
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        #Act
        result = warehouse.valid?

        #Arrange
        expect(result).to eq false 
      end

      it 'falso quando código está vazio' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', 
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        #Act
        result = warehouse.valid?

        #Arrange
        expect(result).to eq false 
      end

      it 'falso quando endereço está vazio' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', 
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        #Act
        result = warehouse.valid?

        #Arrange
        expect(result).to eq false 
      end
    end
      it 'falso quando código já está em uso' do
        #Arrange
        first_warwhouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', 
                                        cep: '25000-000', city: 'Rio', area: 1000,
                                        description: 'Alguma descrição')
        secound_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida', 
                                          cep: '35000-000', city: 'Niteroi', area: 1500,
                                          description: 'Outra descrição')
        #Act
        result = secound_warehouse.valid?

        #Assert
        expect(result).to eq false
      end
  end
end
