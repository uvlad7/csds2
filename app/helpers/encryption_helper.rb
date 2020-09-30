require 'digest'

module EncryptionHelper
  def encrypt(key, data)
    key = Digest::SHA256.digest(key) if (key.kind_of?(String) && 32 != key.bytesize)
    aes = OpenSSL::Cipher.new('IDEA-256-OFB')
    aes.encrypt
    aes.key = key
    aes.update(data) + aes.final
  end

  def decrypt(key, data)
    key = Digest::SHA256.digest(key) if (key.kind_of?(String) && 32 != key.bytesize)
    aes = OpenSSL::Cipher.new('IDEA-256-OFB')
    aes.decrypt
    aes.key = Digest::SHA256.digest(key)
    aes.update(data) + aes.final
  end

  def random_key_32
    SecureRandom.random_bytes(32)
  end

  def self.rsa_encrypt(key, data)
    public_key = OpenSSL::PKey::RSA.new
    public_key.set_key(key[:n], key[:e], key[:d])
    Base64.encode64(public_key.public_encrypt(data))
  end
end
