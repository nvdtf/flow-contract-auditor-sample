import FlowContractAudits from "../contract/FlowContractAudits.cdc"

transaction {

    prepare(auditor: AuthAccount) {

        let auditorProxy <- FlowContractAudits.createAuditorProxy()

        auditor.save(
            <- auditorProxy, 
            to: FlowContractAudits.AuditorProxyStoragePath,
        )
            
        auditor.link<&FlowContractAudits.AuditorProxy{FlowContractAudits.AuditorProxyPublic}>(
            FlowContractAudits.AuditorProxyPublicPath,
            target: FlowContractAudits.AuditorProxyStoragePath
        )
    }
}