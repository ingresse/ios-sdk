//
//  Copyright © 2017 Ingresse. All rights reserved.
//

class SessionDateData : NSObject {
    var id: Int = -1
    var datetime: String = ""
    var date: String = ""
    var time: String = ""

    func applyJSON(_ json: [String:Any]) {
        for key:String in json.keys {
            if !self.responds(to: NSSelectorFromString(key)) || json[key] is NSNull {
                continue
            }

            self.setValue(json[key], forKey: key)
        }
    }
}
