require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      #Arrange
      u = User.new(name: 'Beatriz França', email: 'beatriz@gmail.com')

      #Act
      result = u.description()

      #Assert
      expect(result).to eq('Beatriz França - beatriz@gmail.com')
    end
  end
end
