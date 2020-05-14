//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseService: NSObject {
    
    private let client: IngresseClient
    
    public init(client: IngresseClient) {

        self.client = client
    }
    
    // Lazy vars, only created when needed
    public lazy var payment = PaymentService(client)

    public lazy var address = AddressService(client)

    @objc
    public lazy var auth = AuthService(client)
    
    public lazy var user = UserService(client)
    
    public lazy var userCardWallet = UserCardWalletService(client)

    public lazy var event = EventService(client)

    public lazy var entrance = EntranceService(client)
    
    public lazy var myTickets = MyTicketsService(client)

    @objc
    public lazy var transaction = TransactionService(client)
    
    public lazy var transfers = TransfersService(client)

    public lazy var search = SearchService(client)

    public lazy var security = SecurityService(client)

    public lazy var phone = PhoneService(client)

    public lazy var cashless = CashlessService(client)
}
