class CreateRequestLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :request_logs do |t|
      t.string :request_path, null: false
      t.text :request_body
      t.string :response_code
      t.text :response_body
      t.boolean :success
      t.references :response_template, foreign_key: true
      t.string :error_text

      t.timestamps
    end
  end
end
