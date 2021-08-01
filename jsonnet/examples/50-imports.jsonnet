local defaultResources = import 'libsonnet/default-resources.libsonnet';
local fn = import 'libsonnet/fn-get-resources.libsonnet';
local env = std.extVar("env");
local mul = if (env == "prod") then 2 else 1;

local getResources(mul = 1) = {
   requests: fn.getResources(defaultResources, mul),
   limits: fn.getResources(defaultResources, mul * 2),
};

[{
//  resourcesForProd: getResources(2),
//  resourcesForDev: getResources(1),
//  resourcesCalc: getResources(mul),
//  baseResources: defaultResources,
  resources: getResources(mul),
  env: env,
  namespace: "jsonnet-" + env,
  replicaCount: 3,
  appPort: 8080,
  image: {
    repository: "nginx",
    tag: "1.16.1",
  }
}]
