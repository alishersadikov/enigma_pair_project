class Enigma

  def encrypt(string, key = nil, date = nil)
    encryptor = Encryptor.new(key, date)
    encryptor.encrypt_string(string)
  end

  def decrypt(string, key, date = nil)
    decryptor = Encryptor.new(key, date)
    decryptor.decrypt_string(string)
  end

  def crack(string, date = nil)
    crack = Crack.new(date)
    key = crack.calculate_key(string)
    crack.crack_string(string)
  end
end
