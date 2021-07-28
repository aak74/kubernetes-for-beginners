{
  getResources(base, mul = 1)::
  {
    cpu: base.cpu * mul + 'm',
    memory: base.memory * mul + 'Mb',
  }
}
