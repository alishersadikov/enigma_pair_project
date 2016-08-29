class Enigma

  def encrypt(string, key = nil, date = nil)
    encryptor = Encryptor.new(key, date)
    encryptor.encrypt_string(string)
  end
end
