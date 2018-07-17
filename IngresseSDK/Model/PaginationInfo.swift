//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PaginationInfo: NSObject, Codable {
    public var currentPage: Int = 0
    public var lastPage: Int = 0
    public var totalResults: Int = 0
    public var pageSize: Int = 0
    
    public var isLastPage: Bool {
        get {
            return lastPage <= currentPage
        }
    }
    
    public var nextPage: Int {
        get {
            return currentPage + 1
        }
    }

    public override init() {
        currentPage = 0
        lastPage = 0
        totalResults = 0
        pageSize = 0
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        currentPage = container.safeDecodeTo(Int.self, forKey: .currentPage) ?? 0
        lastPage = container.safeDecodeTo(Int.self, forKey: .lastPage) ?? 0
        totalResults = container.safeDecodeTo(Int.self, forKey: .totalResults) ?? 0
        pageSize = container.safeDecodeTo(Int.self, forKey: .pageSize) ?? 0
    }
}
