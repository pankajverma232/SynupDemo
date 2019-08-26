
import Foundation

protocol DataProviderFactoryProtocol {
    var varientsDataProvider: () -> VarientsDataProviderProtocol {get}
}

class DataProviderFactory: DataProviderFactoryProtocol{
    
    static let shared = DataProviderFactory()
    private init() { }
    
    var varientsDataProvider = { () -> VarientsDataProviderProtocol in
        return VarientsDataProvider()
    }

}
