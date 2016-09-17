-- Research material -- 
-- http://stackoverflow.com/questions/4294689/how-to-generate-an-openssl-key-using-a-passphrase-from-the-command-line
-- http://nategood.com/client-side-certificate-authentication-in-ngi
-- http://www.freebsdmadeeasy.com/tutorials/freebsd/create-a-ca-with-openssl.php
-- http://superuser.com/questions/226192/openssl-without-prompt
-- https://arcweb.co/securing-websites-nginx-and-client-side-certificate-authentication-linux/
-- http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_crl
-- http://superuser.com/questions/724986/how-to-use-password-argument-in-via-command-line-to-openssl-for-decryption
-- http://unix.stackexchange.com/questions/103461/get-common-name-cn-from-ssl-certificate

-- SSL commands used --
--For generating the Certificate Authority Key--
-- openssl  genrsa  -des3 -passout pass:abba -out ../utils/test_certs/ca.key 
--For generating the Certificate Authority certificate--
--openssl req -new -x509 -days 365 -key ../utils/test_certs/ca.key  -passin pass:abba -out ../utils/test_certs/ca.cert -subj "/C=IN/ST=HR/L=GGN/O=wrinq/CN=www.wrinq.com"
-- Decoding the certificate subject line --
-- openssl x509 -noout -subject -in ../utils/test_certs/ca.cert

-- local 
