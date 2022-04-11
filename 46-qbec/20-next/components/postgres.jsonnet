[
  {
    "kind": "Deployment",
    "apiVersion": "apps/v1",
    "metadata": {
      "name": "psql"
    },
    "spec": {
      "selector": {
        "matchLabels": {
          "component": "psql"
        }
      },
      "template": {
        "metadata": {
          "labels": {
            "component": "psql"
          }
        },
        "spec": {
          "containers": [
            {
              "name": "postgres",
              "image": "postgres:11.5",
              "args": [
                "-c",
                "wal_level=logical"
              ]
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
      "name": "psql"
    },
    "spec": {
      "selector": {
        "component": "psql"
      },
      "ports": [
        {
          "name": "psql",
          "targetPort": 5432,
          "port": 5432
        }
      ]
    }
  }
]
