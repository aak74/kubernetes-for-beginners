
local p = import '../params.libsonnet';
local params = p.components.hello;

[
  {
    apiVersion: 'v1',
    kind: 'ConfigMap',
    metadata: {
      name: 'demo-config',
    },
    data: {
      'index.html': params.indexData,
    },
  },
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'demo-deploy',
      labels: {
        app: 'demo-deploy',
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: 'demo-deploy',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'demo-deploy',
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
                name: 'demo-config',
              },
            },
          ],
        },
      },
    },
  },
]
