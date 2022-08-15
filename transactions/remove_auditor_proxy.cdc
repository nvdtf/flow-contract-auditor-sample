/**

  Removes AuditorProxy from account.

*/

import FlowContractAudits from "../contract/FlowContractAudits.cdc"

transaction {

    prepare(auditor: AuthAccount) {

        auditor.unlink(FlowContractAudits.AuditorProxyPublicPath)

        let proxy <- auditor
            .load<@FlowContractAudits.AuditorProxy>(from: FlowContractAudits.AuditorProxyStoragePath)

        destroy proxy

    }
}