
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {
    hello +: {
      indexData: 'hello default 42\n',
      replicas: 8,
      repl: 2,
    },
  }
}
