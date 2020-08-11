class CreateDownPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :down_payments do |t|
      t.boolean :fixed_amount
      t.decimal :percentage
      t.decimal :amount

      t.timestamps
    end
  end
end
