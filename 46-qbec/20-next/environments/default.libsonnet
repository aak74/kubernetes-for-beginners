
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {
    hello +: {
      indexData: 'hello default\n',
      replicas: 2,
    },
  }
}
