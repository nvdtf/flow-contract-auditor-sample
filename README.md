# Managing Flow Contract Audit Vouchers

Demonstrates how a Flow contract auditor can use Flow CLI to generate and manage contract deployment vouchers.

## Setup

1. Insert your account address and key into [flow.json](flow.json) account settings.

2. Initialize your account with `AuditorProxy`:
    ```bash
    flow transactions send transactions/init.cdc \
      --network testnet \
      --signer auditor
    ```
3. The administrator can now authorize access by depositing an `Auditor` capability into your account.

## Generating Vouchers

### Non-Recurrent (default)

Default expiry on [new_audit.cdc](transactions/new_audit.cdc) for single-use vouchers is 30 days.

  ```bash
  flow transactions send transactions/new_audit.cdc \
    0xa6cd6531c4f72c4f \
    "$(jq -R -s '.' < audits/sample_contract.cdc)" \
    --network testnet \
    --signer auditor
  ```

### Recurrent

Recurrent deployments are utility contracts that might be deployed to multiple accounts. 

Default expiry is none.

  ```bash
  flow transactions send transactions/new_recurrent_audit.cdc \
    "$(jq -R -s '.' < audits/sample_contract.cdc)" \
    --network testnet \
    --signer auditor
  ```

## Getting All Vouchers

```bash
flow scripts execute scripts/get_vouchers.cdc --network testnet
```

## Deleting Vouchers

The voucher key format is:

* `any-codehash` for recurrent vouchers
* `address-codehash` for non-recurrent vouchers

```bash
  flow transactions send transactions/remove_audit.cdc \
  "0xa6cd6531c4f72c4f-36f028580bb02cc8272a9a020f4200e346e276ae664e45ee80745574e2f5ab80" \
  --network testnet \
  --signer auditor
```

## Checking Contract Hash

```bash
flow scripts execute scripts/hash_code.cdc \
  "$(jq -R -s '.' < audits/sample_contract.cdc)" \
  --network testnet
```


