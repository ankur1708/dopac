class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :msg_type
      t.text :msg_text
      t.string :attachment_url
      t.string :attachment_ext

      t.timestamps null: false
    end
  end
end
