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