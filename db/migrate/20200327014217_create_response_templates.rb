class CreateResponseTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :response_templates do |t|
      t.string :name
      t.text :body
      t.integer :code

      t.timestamps
    end
  end
end
