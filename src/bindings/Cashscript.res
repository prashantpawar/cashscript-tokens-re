open NodeJs
open Promise
type address = string
type contract = {address: address}
type constructorArgs = array<string>

type provider
type network = [#chipnet | #testnet3 | #testnet4]

@module("cashscript") @new
external newContract: (CashscriptCompiler.artifact, constructorArgs, provider) => contract =
  "Contract"
@module("cashscript") @new
external newElectrumNetworkProvider: network => provider = "ElectrumNetworkProvider"

@send external getBalance: (contract, unit) => Promise.t<int> = "getBalance"

let issueToken = CashscriptCompiler.compileFile(
  Path.join2(Path.resolve(["."]), "/contracts/ISsueToken.cash"),
)

let provider = newElectrumNetworkProvider(#chipnet)
let contract = newContract(issueToken, [], provider)

contract.address->Js.log
contract->getBalance()->thenResolve(balance => Js.log(balance))->ignore
