import Foundation

public struct CUCMonitor {
    
    private let networkManager = NetworkManager()
    
    public func loadData() async -> String {
        //networkManager.getData()
        sleep(1)
        return "string"
    }
}
