# How to check fingerprints of API keys in OCI 

ref: https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm
// Private key
{code}
openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 -c
{code}
