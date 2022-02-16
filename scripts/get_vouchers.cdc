// Retrieves all current vouchers and returns the count.

import FlowContractAudits from "../contract/FlowContractAudits.cdc"

pub fun main(): {String: FlowContractAudits.AuditVoucher} {
    return FlowContractAudits.getAllVouchers()    
}