class ProductModel < ApplicationRecord
  belongs_to :supplier

  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, uniqueness: true 
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }
end
