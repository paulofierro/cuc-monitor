import XCTest
@testable import CUCMonitor

final class NetworkManagerTests: XCTestCase {
    
    let networkManager = NetworkManager()
    let username = ""
    let password = ""
    let meterId = ""
    
    func testLoadingData() throws {
        // 1. First we have to login
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
    
        // 2. Next, we have to finalize the login by loading the redirect
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
        
        // 3. Finally, we load the data
        var maxAttempts = 5
        var dataLoaded = false
        while maxAttempts > 0 {
            dataLoaded = loadData()
            if dataLoaded {
                break
            }
            else {
                log.warn("Data failed to load. Trying again (\(maxAttempts) attempts left)...")
                maxAttempts -= 1
                sleep(3)
            }
        }
        XCTAssertTrue(dataLoaded)
    }
    
    private func loadData() -> Bool {
        let dataExpectation = XCTestExpectation(description: "Data load")
        var dataLoaded = false
        
        networkManager.loadData(
            meterId: meterId,
            completionHandler: { result in
                switch result {
                case .success:
                    dataLoaded = true
                    
                case .failure(let error):
                    log.error("Error: \(error)")
                }
            
                dataExpectation.fulfill()
            }
        )
        
        wait(for: [dataExpectation], timeout: 10)
        return dataLoaded
    }
}
