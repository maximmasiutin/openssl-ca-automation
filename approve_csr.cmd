openssl ca -config C:\max_doc\CA\RSA\openssl.cnf -batch -in %1 -out %2 -rand random.bin -writerand random.bin -create_serial -notext
