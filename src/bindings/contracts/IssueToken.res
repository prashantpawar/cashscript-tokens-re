type functions
type t = {functions: functions, address: Cashscript.address}

@send external transfer: (functions, Cashscript.signatureTemplate) => functions = "transfer"

@send external to: (functions, Cashscript.address, Cashscript.satoshi) => functions = "to"
@send external addFunds: (functions, unit) => functions = "addFunds"
@send external withdraw: (functions, unit) => functions = "withdraw"
