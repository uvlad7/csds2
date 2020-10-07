class NotepadFile < ApplicationRecord
  belongs_to :user
  attr_encrypted :text, key: '759f39cca90e3e65fbfbfa53f78c0468'
end
