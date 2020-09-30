class NotepadFileSerializer
  include FastJsonapi::ObjectSerializer
  include EncryptionHelper
  attributes :name
  attribute :text do |object|
    encrypt(Base64.decode64(current_user.session_key), object.text)
  end
end
