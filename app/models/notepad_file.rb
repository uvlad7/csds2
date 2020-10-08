class NotepadFile < ApplicationRecord
  belongs_to :user
  attr_encrypted :text, key: ENV.fetch('SECURE_NOTEPAD_SECRET') { '759f39cca90e3e65fbfbfa53f78c0468' }, algorithm: 'aes-256-cfb'
end
