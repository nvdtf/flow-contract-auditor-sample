/**
  
  Create a new non-recurrent contract audit voucher for deployment.
  
  The voucher will be burned on first deployment to the target account.
  
  The voucher will be expired in ~30 days.

  Parameters:

  `address`: Target account address for deployment.

  `codeHash`: SHA3-256 hash of the contract.

*/

import FlowContractAudits from "../contract/FlowContractAudits.cdc"

transaction(address: Address, codeHash: String) {
    
    let auditorCapability: &FlowContractAudits.AuditorProxy

    prepare(auditorAccount: AuthAccount) {
        self.auditorCapability = auditorAccount
            .borrow<&FlowContractAudits.AuditorProxy>(from: FlowContractAudits.AuditorProxyStoragePath)
            ?? panic("Could not borrow a reference to the auditor resource")
    }

    execute {
        // ~30 days (1s avg block time)
        let defaultExpiryOffset: UInt64 = 30 * 24 * 60 * 60
        
        self.auditorCapability.addVoucherHashed(address: address, recurrent: false, expiryOffset: defaultExpiryOffset, codeHash: codeHash)        
    }
}