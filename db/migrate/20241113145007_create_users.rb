class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :encrypted_password, null: false, default: ""

      t.timestamps
    end
  end
end
