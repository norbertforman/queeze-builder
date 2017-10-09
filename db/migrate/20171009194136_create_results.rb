class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.string :email
      t.string :name
      t.integer :score
      t.integer :questionnaire_id

      t.timestamps
    end
  end
end
