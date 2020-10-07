require 'digest'

module EncryptionHelper
  def encrypt(key, text)
    t = NodeTask.new './lib/tasks/encrypt.js'
    result = t.run "#{key} #{text}"
    result[:result]
  end

  def self.encrypt(key, text)
    t = NodeTask.new './lib/tasks/encrypt.js'
    result = t.run "#{key} #{text}"
    result[:result]
  end

  def decrypt(key, data)
    t = NodeTask.new './lib/tasks/decrypt.js'
    result = t.run "#{key} #{data}"
    result[:result]
  end

  def self.decrypt(key, data)
    t = NodeTask.new './lib/tasks/decrypt.js'
    result = t.run "#{key} #{data}"
    result[:result]
  end

  def random_key_32
    SecureRandom.hex(16).force_encoding('UTF-8')
  end

  def self.rsa_encrypt(key, data)
    public_key = OpenSSL::PKey::RSA.new(key)
    Base64.encode64(public_key.public_encrypt(data))
  end
end
