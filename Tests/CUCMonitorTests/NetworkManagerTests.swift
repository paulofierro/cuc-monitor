import XCTest
@testable import CUCMonitor

final class NetworkManagerTests: XCTestCase {
    
    let networkManager = NetworkManager()
    let username = ""
    let password = ""
    
    func testLogin() throws {
        let expectation = XCTestExpectation(description: "Login")
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
            
                expectation.fulfill()
            }
        )
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(url)
    }
}
