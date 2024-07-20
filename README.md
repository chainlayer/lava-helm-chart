# lava-helm-chart


## Private Key Configuration
You will need a Lava account exported. 

```yaml
key:
  # The name of the account that is being imported from the private key
  name: ""

  # REQUIRED: The name of the secret containing the private key
  # Example: secretName: "my-secret "
  secretName: ""

  # REQUIRED: The key in the secret containing the private key
  secretKey: ""

  # REQUIRED: The name of the secret containing the private key password
  passwordSecretName: ""

  # REQUIRED: The key in the secret containing the private key password
  passwordSecretKey: ""
```