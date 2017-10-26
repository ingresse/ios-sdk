//
//  GroupTicket.swift
//  Alamofire
//
//  Created by Marcelo Bissuh on 23/10/17.
//

@objcMembers public class GroupTicket: JSONConvertible {
    
    public var id: Int = 0
    public var name: String = ""
    public var desc: String = ""
    public var status: String = ""
    public var type: [EventTicket] = []
    
    public override func applyJSON(_ json: [String:Any]) {
        for (key,value) in json {
            if key == "description" {
                guard let str = value as? String else {
                    continue
                }
                
                self.desc = str
                continue
            }
            
            if key == "type" {
                guard let types = value as? [[String:Any]] else { continue }
                self.populateTickets(types)
                continue
            }
            
            self.applyKey(key, value: value)
        }
    }
    
    private func populateTickets(_ tickets: [[String:Any]]) {
        
        for data in tickets {
            let ticket = EventTicket()
            ticket.applyJSON(data)
            self.type.append(ticket)
        }
        
    }
}

