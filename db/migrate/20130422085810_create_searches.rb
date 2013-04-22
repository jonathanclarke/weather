class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :zipcode, :null => false
      t.string :city
      t.string :state
      t.string :temp_f
      t.text :response
      t.timestamps
    end
  end
end
