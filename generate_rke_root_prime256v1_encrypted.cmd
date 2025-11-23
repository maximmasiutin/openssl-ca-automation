@echo off
REM Generate ECDSA prime256v1 CA with AES-256 encrypted private key (will prompt for passphrase)
openssl ecparam -name prime256v1 -genkey -noout -out ca-prime256v1-pvt-tmp.pem -rand random.bin -writerand random.bin
openssl ec -in ca-prime256v1-pvt-tmp.pem -out ca-prime256v1-pvt.pem -aes256
del ca-prime256v1-pvt-tmp.pem
openssl req -config .\openssl-prime256v1.cnf -x509 -sha256 -new -key ca-prime256v1-pvt.pem -days 10227 -out ca-prime256v1-cert.cer -rand random.bin -writerand random.bin
copy ca-prime256v1-cert.cer kube-ca.pem
copy ca-prime256v1-pvt.pem kube-service-account-token-key.pem
copy ca-prime256v1-cert.cer kube-apiserver-requestheader-ca.pem
copy ca-prime256v1-pvt.pem kube-apiserver-requestheader-ca-key.pem
