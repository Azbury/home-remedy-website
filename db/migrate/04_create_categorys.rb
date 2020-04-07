class CreateCategorys < ActiveRecord::Migration[4.2]
    def change
        create_table :categorys do |t|
            t.string :name
            t.integer :remedy_id

            t.timestamps null: false
        end
    end
end