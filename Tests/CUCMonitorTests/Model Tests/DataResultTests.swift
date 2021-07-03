@testable import CUCMonitor
import XCTest

final class DataResultTests: XCTestCase {
    let meterId = "METER_ID"

    func testDecodingJSON() throws {
        let data = try XCTUnwrap(Data.loadJSON(from: "Resources/data-result", bundle: Bundle.module))
        let result = try JSONDecoder().decode(DataResult.self, from: data)
        
        XCTAssertNotNil(result)
        XCTAssertTrue(result.weather.isNotEmpty)
        XCTAssertTrue(result.usage.isNotEmpty)
        log.debug("Total usage results: \(result.usage.count)")
    }
}
