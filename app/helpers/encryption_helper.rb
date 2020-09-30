require 'digest'

module EncryptionHelper
  AES = 'AES-256-CFB'

  def encrypt(key, text)
    key = Digest::SHA256.digest(key) if (key.kind_of?(String) && 32 != key.bytesize)
    aes = OpenSSL::Cipher.new(AES)
    aes.encrypt
    iv = aes.random_iv
    aes.key = key
    (iv + aes.update(text) + aes.final).force_encoding('UTF-8')
  end

  def decrypt(key, data)
    key = Digest::SHA256.digest(key) if (key.kind_of?(String) && 32 != key.bytesize)
    aes = OpenSSL::Cipher.new(AES)
    aes.decrypt
    bytes = data.bytes
    iv, text = [bytes[0...16], bytes[16..-1]].map { |arr| arr.pack('c*') }
    aes.iv = iv
    aes.key = key
    (aes.update(text) + aes.final).force_encoding('UTF-8')
  end

  def random_key_32
    SecureRandom.random_bytes(32)
  end

  def self.rsa_encrypt(key, data)
    public_key = OpenSSL::PKey::RSA.new(key)
    Base64.encode64(public_key.public_encrypt(data))
  end
end
