As a sample, the policygateway ships with a Keystore(pgkeystore.jks) and Cacert Store(cacerts) and the certificate of the Signing Authority (lhcacert.der).
The Signing Authorities Public Cert has already been imported into cacerts.
The 
We also give give the Public Certificate (signed by lhcacert.der) and private keys
1)localhostcert.der (private key is localhostpk.der) 
2)partner1cert.der (private key is partner1pk.der)
3)partner2cert.der (private key is partner2pk.der)

These Public/Private key pairs have also been imported into the keystore and truststore.

pgkeystore.jks. It contains the following aliases and Key Pairs
- policygateway (localhostcert and localhostpk)
- partner1 (partner1cert and partner1pk)
- partner2 (partner2cert and partner2pk)
- storepass = password
- keypass = password
(note: both storepass and keypass must be the same, or you'll get weird SSL errors like 'cannot recover key'
and 'Unconnected sockets not implemented' :))

localhostcert.der (signed by lhcacert.der)
- certificate of alias 'policygateway'

cacerts (this is the Trust Store)
- taken from {JAVA_HOME}/jre/lib/security
- contains CA certs 
- The Signining Authority of all the Key Pairs in pgkeystore.jks is lhcacert and has been imported into this trustsore
- default storepass = changeit
- contains Synapse-1.1 cert to test interop with sample axis2server 
