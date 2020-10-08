class AddAttrEncryptedForNotepad < ActiveRecord::Migration[5.1]
  def change
    add_column :notepad_files, :encrypted_text, :string
    add_column :notepad_files, :encrypted_text_iv, :string
    add_index :notepad_files, :encrypted_text_iv, unique: true
    remove_column :notepad_files, :text
  end
end
