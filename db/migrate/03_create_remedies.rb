class CreateRemedies < ActiveRecord::Migration[4.2]
    def change
        create_table :remedies do |t|
            t.string :title
            t.text :description
            t.integer :user_id

            t.timestamps null: false
        end
    end
end