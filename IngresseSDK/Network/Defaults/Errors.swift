//
//  Copyright © 2020 Ingresse. All rights reserved.
//

struct Errors {
    
    public struct Code6xxx {
        public static let invalidToken = 6062
        public static let expiredToken = 6065
    }
    
    public struct Code2xxx {
        public static let invalidToken = 2006
    }
    
    public static let tokenError = [Code6xxx.invalidToken,
                                    Code6xxx.expiredToken,
                                    Code2xxx.invalidToken]
}
