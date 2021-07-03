@testable import CUCMonitor
import XCTest

final class NetworkManagerTests: XCTestCase {
    let networkManager = NetworkManager()
    let username = ""
    let password = ""
    let maxAttempts = 10
    
    func testLoadingData() throws {
        // 1. First we have to login
        let redirectURL = try performLogin()

        // 2. Next, we have to finalize the login by loading the redirect
        try performRedirect(redirectURL: redirectURL)

        // 3. Load the meter ID
        let meterId: String? = performBlock(maxAttempts: maxAttempts) {
            self.loadMeterId()
        }

        let unwrappedMeterId = try XCTUnwrap(meterId)
        XCTAssertNotNil(unwrappedMeterId)

        // 4. Finally, we load the data
        let result: DataResult? = performBlock(maxAttempts: maxAttempts) {
            self.loadData(meterId: unwrappedMeterId)
        }
        XCTAssertNotNil(result)

        // Check the contents
        let data = try XCTUnwrap(result)
        XCTAssertEqual(data.meterId, meterId)
        XCTAssertTrue(data.weather.isNotEmpty)
        XCTAssertTrue(data.usage.isNotEmpty)
        
        log.debug("Total usage results: \(data.usage.count)")
    }
}

extension NetworkManagerTests {
    /// Logs in and returns the redirect URL
    private func performLogin() throws -> String {
        let loginExpectation = XCTestExpectation(description: "Login")
        var url: String?

        networkManager.login(
            username: username,
            password: password,
            completionHandler: { result in
                switch result {
                case .success(let redirectURL):
                    url = redirectURL

                case .failure(let error):
                    log.error("Error: \(error)")
                }

                loginExpectation.fulfill()
            }
        )

        wait(for: [loginExpectation], timeout: 10)
        let redirectURL = try XCTUnwrap(url)
        XCTAssertNotNil(redirectURL)
        return redirectURL
    }

    /// Loads the redirect URL
    private func performRedirect(redirectURL: String) throws {
        let redirectExpectation = XCTestExpectation(description: "Redirect")
        var success = false

        networkManager.loadRedirect(
            redirectURL: redirectURL,
            completionHandler: { result in
                switch result {
                case .success:
                    success = true

                case .failure(let error):
                    log.error("Error: \(error)")
                }

                redirectExpectation.fulfill()
            }
        )

        wait(for: [redirectExpectation], timeout: 10)
        XCTAssertTrue(success)
    }

    /// Loads the meter ID and returns it
    private func loadMeterId() -> String? {
        let findMeterExpectation = XCTestExpectation(description: "Load Meter")
        var meterId: String?

        networkManager.findMeterId(
            completionHandler: { result in
                switch result {
                case .success(let data):
                    meterId = data

                case .failure(let error):
                    log.error("Error: \(error)")
                }

                findMeterExpectation.fulfill()
            }
        )

        wait(for: [findMeterExpectation], timeout: 10)
        return meterId
    }

    /// Loads the data for a meter and returns it
    private func loadData(meterId: String) -> DataResult? {
        let dataExpectation = XCTestExpectation(description: "Data load")
        var dataResult: DataResult?

        networkManager.loadData(
            meterId: meterId,
            completionHandler: { result in
                switch result {
                case .success(let data):
                    dataResult = data

                case .failure(let error):
                    log.error("Error: \(error)")
                }

                dataExpectation.fulfill()
            }
        )

        wait(for: [dataExpectation], timeout: 10)
        return dataResult
    }

    /// Performs a block n-number of times, with a 5 second timeout in-between runs
    private func performBlock<T>(maxAttempts: Int, timeout: UInt32 = 5, block: @escaping () -> T?) -> T? {
        var currentAttempt = maxAttempts
        while currentAttempt > 0 {
            if let result = block() {
                return result
            }
            log.warn("Block failed. Trying again — (\(currentAttempt) attempts left)...")
            currentAttempt -= 1
            sleep(timeout)
        }
        return nil
    }
}
