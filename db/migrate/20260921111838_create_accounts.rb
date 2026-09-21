class CreateAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :addr1
      t.string :addr2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.jsonb :settings, null: false, default: {}
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
