@unboxed type satoshi = Satoshi(int)
type address = string
type signature
type signatureTemplate = {
  hashtype: int,
  signatureAlgorithm: int,
  privateKey: LibAuth.privKey,
}
type constructorArgs = array<LibAuth.pubKey>
type wif = string
type hashType
type hashTypes = {
  @as("SIGHASH_ALL") sighash_all: hashType,
  @as("SIGHASH_NONE") sighash_none: hashType,
  @as("SIGHASH_SINGLE") sighash_single: hashType,
  @as("SIGHASH_ANYONECANPAY") sighash_anyonecanpay: hashType,
  @as("SIGHASH_BITCOINCASH_BIP143") sighash_bitcoincash_bip143: hashType,
  @as("ADVANCED_TRANSACTION_MARKER") advanced_transaction_marker: hashType,
  @as("ADVANCED_TRANSACTION_FLAG") advanced_transaction_flag: hashType,
}

@module("cashscript") @val external hashTypes: hashTypes = "HashType"

type provider
type network = [#chipnet | #testnet3 | #testnet4]

@module("cashscript") @new
external newContract: (CashscriptCompiler.artifact, constructorArgs, provider) => 'contract =
  "Contract"
@module("cashscript") @new
external newElectrumNetworkProvider: network => provider = "ElectrumNetworkProvider"

@send external getBalance: ('contract, unit) => Promise.t<int> = "getBalance"
@val @scope(("process", "env")) external privateKey: wif = "PRIVATE_KEY"
@module("cashscript") @new
external newSignatureTemplate: (wif, hashType) => signatureTemplate = "SignatureTemplate"
