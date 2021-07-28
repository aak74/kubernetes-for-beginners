local getResources(mul = 1) = {
   cpu: 100 * mul + 'm',
   memory: 256 * mul + 'Mb',
};

[
{
  resources: {
    limits: getResources(2),
    requests: getResources(),
  },
  image: {
    repository: "nginx",
    tag: ""
  },
  appPort: 80
}
]
