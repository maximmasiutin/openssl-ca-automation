openssl ca -config .\openssl-prime256v1.cnf -batch -in %1 -out %2 -rand random.bin -writerand random.bin -create_serial -notext
