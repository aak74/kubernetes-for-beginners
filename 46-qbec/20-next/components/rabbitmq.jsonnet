[
  {
    "kind": "Deployment",
    "apiVersion": "apps/v1",
    "metadata": {
      "name": "rabbitmq"
    },
    "spec": {
      "selector": {
        "matchLabels": {
          "component": "rabbitmq"
        }
      },
      "strategy": {
        "type": "Recreate"
      },
      "template": {
        "metadata": {
          "labels": {
            "component": "rabbitmq"
          }
        },
        "spec": {
          "containers": [
            {
              "name": "rabbitmq",
              "image": "rabbitmq:3",
            }
          ]
        }
      }
    }
  },
  {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "rabbitmq"
    },
    "spec": {
      "selector": {
        "component": "rabbitmq"
      },
      "ports": [
        {
          "port": 5672
        }
      ]
    }
  },
]
