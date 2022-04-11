
local p = import '../params.libsonnet';
local params = p.components.hello;
local prefix = 'demo2-';

[
  {
    apiVersion: 'v1',
    kind: 'ConfigMap',
    metadata: {
      name: prefix + 'config',
    },
    data: {
      'index.html': params.indexData,
    },
  },
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: prefix + 'deploy',
      labels: {
        app: prefix + 'deploy',
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: prefix + 'deploy',
        },
      },
      template: {
        metadata: {
          labels: {
            app: prefix + 'deploy',
          },
        },
        spec: {
          containers: [
            {
              name: 'main',
              image: 'nginx:stable',
              imagePullPolicy: 'Always',
              volumeMounts: [
                {
                  name: 'web',
                  mountPath: '/usr/share/nginx/html',
                },
              ],
            },
          ],
          volumes: [
            {
              name: 'web',
              configMap: {
                name: prefix + 'config',
              },
            },
          ],
        },
      },
    },
  },
]
