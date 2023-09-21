import XCTest

class PaginableTests: XCTestCase {
    func testHasMorePages() {
        var paginable = MovieResult(results: [], currentPage: 1, totalPages: 2)
        XCTAssertTrue(paginable.hasMorePages)

        paginable.currentPage = paginable.totalPages
        XCTAssertFalse(paginable.hasMorePages)
    }

    func testNextPage() {
        var paginable = MovieResult(results: [], currentPage: 2, totalPages: 3)
        XCTAssertEqual(paginable.nextPage, 3)

        paginable.currentPage = paginable.totalPages
        XCTAssertEqual(paginable.nextPage, paginable.currentPage)
    }
}
