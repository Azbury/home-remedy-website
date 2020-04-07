class CreateComments < ActiveRecord::Migration[4.2]
    def change
        create_table :comments do |t|
            t.text :content
            t.integer :user_id
            t.integer :remedy_id

            t.timestamps null: false
        end
    end
end