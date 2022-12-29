type privKey
type pubKey
type secp256k1
@module("@bitauth/libauth")
external instantiateSecp256k1: unit => Promise.t<secp256k1> = "instantiateSecp256k1"

@send
external derivePublicKeyCompressed: (secp256k1, privKey) => pubKey = "derivePublicKeyCompressed"

@module("@bitauth/libauth")
external binToHex: unit => Promise.t<secp256k1> = "binToHex"
