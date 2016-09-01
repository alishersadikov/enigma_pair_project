Enigma Encryption Engine

This project is based on the actual Enigma machine that was used during the World War 2. It uses a five digit key and date to create four rotations which are then used to encode text. If not given, the key is generated randomly and the date is the date whenever the program is running. All characters are supported (88) except for single and double quotes.

This program also decrypts encrypted text as long as the key and the date are provided. The most interesting part, however, is cracking the encrypted message without the key and with given date, which is based on the assumption that all messages end with "..end..". Subsequently, the key is calculated and provided.

Runner files in the lib folder and and text files ares used for file I/O. This project also utilizes a rakefile and simplecov. 
