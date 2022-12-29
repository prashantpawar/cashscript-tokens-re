open NodeJs
open Cashscript

let main = _ => {
  open Promise
  Dotenv.config()

  LibAuth.instantiateSecp256k1()->thenResolve(secp256k1 => {
    let sig = newSignatureTemplate(privateKey, hashTypes.sighash_all)
    let _pubKey = secp256k1->LibAuth.derivePublicKeyCompressed(sig.privateKey)

    let issueToken = CashscriptCompiler.compileFile(
      Path.join2(Path.resolve(["."]), "/contracts/IssueToken.cash"),
    )

    let provider = newElectrumNetworkProvider(#chipnet)
    let contract: IssueToken.t = newContract(issueToken, [], provider)

    contract.address->Js.log
    contract->getBalance()->thenResolve(balance => Js.log(balance))
    /*
    ->thenResolve(_ => {
      contract.functions
      ->Safe.transfer(sig)
      ->Safe.to("bchtest:qrd7kvfyk620r79rz0dflx3splh6gwmy2s3jsd9gws", Satoshi(899561))
      ->Safe.send()
    })
 */
  })
}

main()
->Promise.thenResolve(_ => {
  Js.log("done")
})
->ignore
