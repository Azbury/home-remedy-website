class CreateRemedyCategories < ActiveRecord::Migration[4.2]
    def change
      create_table :remedy_categories do |t|
        t.integer :remedy_id
        t.integer :category_id

        t.timestamps null: false
      end
    end
  end