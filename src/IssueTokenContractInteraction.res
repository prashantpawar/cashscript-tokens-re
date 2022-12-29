open NodeJs
open Cashscript

let compile = _ => {
  open Promise
  Dotenv.config()

  LibAuth.instantiateSecp256k1()->then(secp256k1 => {
    let sig = newSignatureTemplate(privateKey, hashTypes.sighash_all)
    let _pubKey = secp256k1->LibAuth.derivePublicKeyCompressed(sig.privateKey)

    let issueToken = CashscriptCompiler.compileFile(
      Path.join2(Path.resolve(["."]), "/contracts/IssueToken.cash"),
    )

    let provider = newElectrumNetworkProvider(#chipnet)
    let contract: IssueToken.t = newContract(issueToken, [], provider)

    contract.address->Js.log
    contract
    ->getBalance()
    ->thenResolve(balance => {
      Js.log(balance)
      contract
    })
  })
}

let setupCommander = _ => {
  open Promise
  open Commander
  let _ =
    program->name("IssueToken.cash")->description("CLI to interact with IssueToken smart contract")

  let _ =
    program
    ->command("compile")
    ->description("Compile the contract")
    ->action((_str, _options) => {
      compile()
      ->thenResolve(_ => {
        Js.log("done")
      })
      ->ignore
    })

  let _ =
    program
    ->command("addFunds")
    ->description("Call the addFunds method")
    ->action((_str, _options) => {
      compile()
      ->then((contract: IssueToken.t) => {
        contract.functions
        ->IssueToken.addFunds()
        ->IssueToken.to("bchtest:qrd7kvfyk620r79rz0dflx3splh6gwmy2s3jsd9gws", Satoshi(1000))
        ->IssueToken.send()
      })
      ->thenResolve(_ => Js.log("done"))
      ->ignore
    })
  program->parse()
}

setupCommander()->ignore

/*
 */
