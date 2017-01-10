//
//  IngresseService_Events.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/8/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation

extension IngresseService {
    
    /**
        Get attributes of event
     
        - parameter eventCode: ID of the event
        - parameter page:      Current page
        - parameter userToken: Token of user
     
        - parameter completionHandler: Callback block in case of success
     */
    public func getEventAttributes(_ eventCode: String, completion: @escaping (_ success: Bool, _ attributes: EventAttributes?)->()) {
        let path = "event/\(eventCode)/attributes"
        
        let url = makeURL(path, parameters: [:], userToken: nil)
        
        GET(url) { (success: Bool, response: [String:Any]) in
            
            var attributes: EventAttributes? = nil
            
            if success {
                attributes = EventAttributes()
                
                do {
                    try attributes!.inputData(response)
                } catch {
                    completion(false, nil)
                    return
                }
            }
            
            completion(success, attributes)
        }
    }

}
