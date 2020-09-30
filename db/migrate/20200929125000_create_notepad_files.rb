class CreateNotepadFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :notepad_files do |t|

      t.timestamps
    end
  end
end
