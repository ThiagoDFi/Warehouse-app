class AddPhoneNumberToSupplier < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :phone_number, :integer
  end
end
