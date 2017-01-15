class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.text :description
      t.integer :deviceFunction
      t.integer :node_id
      t.integer :io
      t.integer :pin

      t.timestamps
    end
  end
end
