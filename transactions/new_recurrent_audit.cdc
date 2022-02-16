/**
  
  Create a new recurrent contract audit voucher for deployment.
  
  The voucher can be used to deploy the specified contract to any account 
  by any user.
  
  The voucher will NOT expire.

  Parameters:

  `code`: Full source code of the audited contract. The code will be 
          hashed and checked against future contract deployments.

*/

import FlowContractAudits from "../contract/FlowContractAudits.cdc"

transaction(code: String) {
    
    let auditorCapability: &FlowContractAudits.AuditorProxy

    prepare(auditorAccount: AuthAccount) {
        self.auditorCapability = auditorAccount
            .borrow<&FlowContractAudits.AuditorProxy>(from: FlowContractAudits.AuditorProxyStoragePath)
            ?? panic("Could not borrow a reference to the auditor resource")
    }

    execute {
        self.auditorCapability.addVoucher(address: nil, recurrent: true, expiryOffset: nil, code: code)        
    }
}