class CreateGrants < ActiveRecord::Migration[5.1]
  def change
    create_table :grants do |t|
<<<<<<< HEAD
      t.string 	:fiscal_year
      t.string 	:grant_type
      t.string 	:organization
      t.text 	:project
      t.decimal :amount, :precision => 10, :scale => 2
      t.string 	:location
      t.string 	:strategic_priority
      t.string 	:strategic_results
=======
      t.integer :fiscal_year
      t.text 	:grant_type
      t.text  	:organization
      t.text 	:project
      t.decimal :amount, :precision => 10, :scale => 2
      t.text  	:location
      t.text  	:strategic_priority
      t.text  	:strategic_results
>>>>>>> e98558437a7901ee9e387e4f89d25afb89cc82ea
      t.integer :total_served
      t.integer :nh_served
      t.integer :grantStatusID

    end
  end
end
