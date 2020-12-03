//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct UpdateTransferRequest: Encodable {

    public let parameters: Self.Parameters
    public let body: Self.Body

    public init(usertoken: String,
                action: Body.TransferAction) {

        self.parameters = Parameters(usertoken: usertoken)

        self.body = Body(action: action)
    }

    public struct Parameters: Encodable {

        public let usertoken: String

        public init(usertoken: String) {

            self.usertoken = usertoken
        }
    }

    public struct Body: Encodable {

        public let action: String
        
        public init(action: TransferAction) {
            self.action = action.rawValue
        }

        public enum TransferAction: String {
            case accept
            case refuse
            case cancel
        }
    }
}
