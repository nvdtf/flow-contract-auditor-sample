import FlowContractAudits from "../contract/FlowContractAudits.cdc"

pub fun main(code: String): String {
    return FlowContractAudits.hashContractCode(code)    
}