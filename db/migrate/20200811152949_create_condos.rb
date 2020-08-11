class CreateCondos < ActiveRecord::Migration[6.0]
  def change
    create_table :condos do |t|
      t.decimal :price, default: 300000
      t.decimal :hoa, default: 400
      t.decimal :tax, default: 0
      t.decimal :insurance, default: 50
      t.string :name
      t.string :notes
      t.belongs_to :mortgage

      t.timestamps
    end
  end
end
