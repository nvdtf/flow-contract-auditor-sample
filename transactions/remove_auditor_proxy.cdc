/**

  Initialize the auditor account by creating an empty AuditorProxy.

  After this transaction, the admin will have to run admin/authorize_auditor.cdc
  to deposit an Auditor capability into the proxy.

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