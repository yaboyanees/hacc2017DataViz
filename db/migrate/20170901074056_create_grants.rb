class CreateGrants < ActiveRecord::Migration[5.1]
  def change
    create_table :grants do |t|
      t.integer :fiscal_year
      t.string :grant_type
      t.text :organization
      t.text :project
      t.integer :amount
      t.string :location
      t.string :strategic_priority
      t.string :strategic_results
      t.integer :total_served
      t.integer :nh_served
      t.integer :grantStatusID

      t.timestamps
    end
  end
end
