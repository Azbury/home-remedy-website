class CreateUsers < ActiveRecord::Migration[4.2]
    def change
        create_table :users do |t|
            t.string :username
            t.string :first_name
            t.string :last_name
            t.integer :age
            t.text :bio
            t.string :password_digest

            t.timestamps null: false
        end
    end
end