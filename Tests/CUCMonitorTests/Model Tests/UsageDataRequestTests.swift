@testable import CUCMonitor
import XCTest

final class UsageDataRequestTests: XCTestCase {
    let meterId = "METER_ID"

    func testEncodingJSON() throws {
        let request = UsageDataRequest(meterId: meterId)
        let json = try request.toJSONString()
        XCTAssertNotNil(json)
    }
}
