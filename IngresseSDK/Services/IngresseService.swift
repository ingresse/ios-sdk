//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseService: NSObject {
    
    private let client: IngresseClient
    
    public init(client: IngresseClient) {

        self.client = client
    }
    
    // Lazy vars, only created when needed
    public lazy var payment: PaymentService = {
        [unowned self] in
        return PaymentService(self.client)
        }()

    public lazy var address: AddressService = {
        [unowned self] in
        return AddressService(self.client)
        }()

    @objc public lazy var auth: AuthService = {
        [unowned self] in
        return AuthService(self.client)
        }()
    
    public lazy var user: UserService = {
        [unowned self] in
        return UserService(self.client)
        }()
    
    public lazy var userCardWallet: UserCardWalletService = {
        [unowned self] in
        return UserCardWalletService(self.client)
        }()

    public lazy var event: EventService = {
        [unowned self] in
        return EventService(self.client)
        }()

    public lazy var entrance: EntranceService = {
        [unowned self] in
        return EntranceService(self.client)
        }()
    
    public lazy var myTickets: MyTicketsService = {
        [unowned self] in
        return MyTicketsService(self.client)
        }()
    
    @objc public lazy var transaction: TransactionService = {
        [unowned self] in
        return TransactionService(self.client)
        }()
    
    public lazy var transfers: TransfersService = {
        [unowned self] in
        return TransfersService(self.client)
        }()

    public lazy var search: SearchService = {
        [unowned self] in
        return SearchService(self.client)
        }()

    public lazy var security: SecurityService = {
        [unowned self] in
        return SecurityService(self.client)
        }()

    public lazy var phone: PhoneService = {
        [unowned self] in
        return PhoneService(self.client)
        }()
}
