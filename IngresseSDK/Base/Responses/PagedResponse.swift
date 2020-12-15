//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct PagedResponse<V: Decodable>: Decodable {
    public let paginationInfo: Self.PaginationInfo?
    public let data: [V]?
    
    public struct PaginationInfo: Decodable {
        public let currentPage: Int
        public let lastPage: Int
        public let totalResults: Int
        
        public func isLastPage() -> Bool { currentPage >= lastPage }
        public func nextPage() -> Int { currentPage + 1 }
    }
}
