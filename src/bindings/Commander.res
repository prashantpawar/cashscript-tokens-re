type t
@module("commander") external program: t = "program"

@send external option: (t, string) => t = "option"
@send external command: (t, string) => t = "command"
@send external name: (t, string) => t = "name"
@send external description: (t, string) => t = "description"
@send external version: (t, string) => t = "version"
@send external argument: (t, string, string) => t = "argument"
@send external parse: (t, unit) => t = "parse"
@send external opts: (t, unit) => 'options = "opts"
@send external action: (t, (string, 'options) => unit) => unit = "action"
