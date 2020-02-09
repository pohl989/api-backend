class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.integer :status, default: 0, index: true

      t.timestamps
    end
  end
end
