class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :created_at
  attribute :session_key do |user|
    rsa_encrypt(user.rsa_pub, user.session_key)
  end
end
