class CreateMortgages < ActiveRecord::Migration[6.0]
  def change
    create_table :mortgages do |t|
      t.decimal :rate, default: 2.875
      t.integer :years, default: 30

      t.timestamps
    end
  end
end
