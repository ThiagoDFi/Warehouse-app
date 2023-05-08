class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, uniqueness: true 
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }

  def dimension
    "#{height}cm x #{width}cm x #{depth}cm"
  end
end
