import XCTest
@testable import CUCMonitor

final class NetworkManagerTests: XCTestCase {
    
    let networkManager = NetworkManager()
    let username = ""
    let password = ""
    
    func testLogin() throws {
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
}
