class CreateRemedys < ActiveRecord::Migration[4.2]
    def change
        create_table :remedys do |t|
            t.string :title
            t.text :description
            t.integer :user_id
            t.integer :category_id

            t.timestamps null: false
        end
    end
end