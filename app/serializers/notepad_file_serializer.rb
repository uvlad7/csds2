class NotepadFileSerializer
  include FastJsonapi::ObjectSerializer
  include EncryptionHelper
  attributes :name
  attribute :text do |object|
    EncryptionHelper.encrypt(object.user.session_key, object.text)
  end
end
