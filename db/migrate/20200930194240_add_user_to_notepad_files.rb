class AddUserToNotepadFiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :notepad_files, :user, foreign_key: true
    add_column :notepad_files, :text, :text
    add_column :notepad_files, :name, :string
  end
end
