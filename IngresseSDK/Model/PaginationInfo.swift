//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PaginationInfo: NSObject, Codable {
    public var currentPage: Int = 0
    public var lastPage: Int = 0
    public var totalResults: Int = 0
    public var pageSize: Int = 0
    
    public var isLastPage: Bool {
        return lastPage <= currentPage
    }
    
    public var nextPage: Int {
        return currentPage + 1
    }

    public override init() {
        currentPage = 0
        lastPage = 0
        totalResults = 0
        pageSize = 0
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        currentPage = container.decodeKey(.currentPage, ofType: Int.self)
        lastPage = container.decodeKey(.lastPage, ofType: Int.self)
        totalResults = container.decodeKey(.totalResults, ofType: Int.self)
        pageSize = container.decodeKey(.pageSize, ofType: Int.self)
    }
}
