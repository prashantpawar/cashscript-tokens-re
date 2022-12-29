type functions
type t = {functions: functions, address: Cashscript.address}

@send external transfer: (functions, Cashscript.signatureTemplate) => functions = "transfer"

@send external to: (functions, Cashscript.address, Cashscript.satoshi) => functions = "to"
@send external send: (functions, unit) => functions = "send"
