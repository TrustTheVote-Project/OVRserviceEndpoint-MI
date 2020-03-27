class CreateResponseRules < ActiveRecord::Migration[6.0]
  def change
    create_table :response_rules do |t|
      t.string :name
      t.string :path
      t.references :response_template, null: false, foreign_key: true
      t.integer :response_code
      t.text :conditions
      t.integer :sleep
      t.boolean :raise_error

      t.timestamps
    end
  end
end
