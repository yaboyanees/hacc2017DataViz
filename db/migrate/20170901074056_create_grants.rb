class CreateGrants < ActiveRecord::Migration[5.1]
  def change
    create_table :grants do |t|
      t.string 	:fiscal_year
      t.string 	:grant_type
      t.string 	:organization
      t.text 	:project
      t.decimal :amount, :precision => 10, :scale => 2
      t.string 	:location
      t.string 	:strategic_priority
      t.string 	:strategic_results
      t.integer :total_served
      t.integer :nh_served
      t.integer :grantStatusID

      t.timestamps
    end
  end
end
