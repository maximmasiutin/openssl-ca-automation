@echo off
REM Generate RSA CA with AES-256 encrypted private key (will prompt for passphrase)
openssl genrsa -aes256 -out rsa-ca-pvt.pem 4096 -rand random.bin -writerand random.bin
openssl req -config .\openssl-rsa.cnf -x509 -sha512 -new -key rsa-ca-pvt.pem -days 10227 -out rsa-ca-cert.cer
copy rsa-ca-cert.cer kube-ca.pem
copy rsa-ca-pvt.pem kube-service-account-token-key.pem
copy rsa-ca-cert.cer kube-apiserver-requestheader-ca.pem
copy rsa-ca-pvt.pem kube-apiserver-requestheader-ca-key.pem
