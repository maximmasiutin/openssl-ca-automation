openssl ecparam -name prime256v1 -genkey -noout -out ca-prime256v1-pvt.pem -rand random.bin -writerand random.bin
openssl req -config .\openssl-prime256v1.cnf -x509 -sha256 -new -nodes -key ca-prime256v1-pvt.pem -days 10227 -out ca-prime256v1-cert.cer -rand random.bin -writerand random.bin
copy ca-prime256v1-cert.cer kube-ca.pem
copy ca-prime256v1-pvt.pem kube-service-account-token-key.pem
copy ca-prime256v1-cert.cer kube-apiserver-requestheader-ca.pem
copy ca-prime256v1-pvt.pem kube-apiserver-requestheader-ca-key.pem
