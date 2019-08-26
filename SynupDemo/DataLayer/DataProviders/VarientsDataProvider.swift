
import Foundation

protocol VarientsDataProviderProtocol {
    
    func fetchVarients(_ request: HomeModel.Request?, _ completion: @escaping (HomeModel.Response?, _ error:Error?)->())
}

class VarientsDataProvider: VarientsDataProviderProtocol {
    //MARK: - VarientsProviderLogic implementation
    
   func fetchVarients(_ request: HomeModel.Request?, _ completion: @escaping (HomeModel.Response?, _ error:Error?)->()) {
        let url = Constants.urls.varients
        RemoteDataProvider.request(urlPath: url) { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(HomeModel.Response.self, from: data!)
                completion(response, nil)
            } catch let err {
                completion(nil, err)
            }
        }
    }
}
