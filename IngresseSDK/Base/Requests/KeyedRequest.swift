//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct KeyedRequest<R: Encodable>: Encodable {
    let request: R
    let key: KeyRequest
    
    init(request: R,
         apikey: String) {
        
        self.request = request
        self.key = KeyRequest(apikey: apikey)
    }
    
    init(request: R,
         key: KeyRequest) {
        
        self.request = request
        self.key = key
    }
    
    public func encode(to encoder: Encoder) throws {
        try request.encode(to: encoder)
        try key.encode(to: encoder)
    }
    
    public struct KeyRequest: Encodable {
        
        let apikey: String
        
        init(apikey: String) {
            self.apikey = apikey
        }
    }
}
