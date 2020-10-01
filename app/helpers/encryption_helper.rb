require 'digest'

module EncryptionHelper
  def encrypt(key, text)
    key = Digest::SHA256.hexdigest(key) if (key.kind_of?(String) && 32 != key.bytesize)
    crypt = Chilkat::CkCrypt2.new
    crypt.put_CryptAlgorithm('aes')
    crypt.put_CipherMode('cfb')
    crypt.put_KeyLength(256)
    crypt.put_PaddingScheme(0)
    crypt.put_EncodingMode('hex')
    iv = SecureRandom.hex(8)
    crypt.SetEncodedIV(iv, 'hex')
    crypt.SetEncodedKey(key, 'hex')
    data = (iv + crypt.encryptStringENC(text)).force_encoding('UTF-8')
  end

  def decrypt(key, data)
    key = Digest::SHA256.hexdigest(key) if (key.kind_of?(String) && 32 != key.bytesize)
    crypt = Chilkat::CkCrypt2.new
    crypt.put_CryptAlgorithm('aes')
    crypt.put_CipherMode('cfb')
    crypt.put_KeyLength(256)
    crypt.put_PaddingScheme(0)
    crypt.put_EncodingMode('hex')
    bytes = data.bytes
    iv, text = [bytes[0...16], bytes[16..-1]].map { |arr| arr.pack('c*') }
    crypt.SetEncodedIV(iv, 'hex')
    crypt.SetEncodedKey(key, 'hex')
    crypt.decryptStringENC(text).force_encoding('UTF-8')
  end

  def random_key_32
    SecureRandom.hex(16).force_encoding('UTF-8')
  end

  def self.rsa_encrypt(key, data)
    public_key = OpenSSL::PKey::RSA.new(key)
    Base64.encode64(public_key.public_encrypt(data))
  end
end
