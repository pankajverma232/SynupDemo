//
//  RemoteDataProvider.swift
//  ContactsDemo
//
//  Created by Pankaj Verma on 18/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import Foundation

enum NetworkError:Error{
    case client
    case server
    case mimeType
    case dataNil
    case invalidUrl
    
    public var localizedDescription: String?{
        var description =  ""
        switch self {
        case .client: description = Constants.Strings.NetworkError.client
        case .server: description = Constants.Strings.NetworkError.server
        case .mimeType: description = Constants.Strings.NetworkError.mimeType
        case .dataNil: description = Constants.Strings.NetworkError.noData
        case .invalidUrl: description = Constants.Strings.NetworkError.invalidUrl
        }
        return description
    }
}

class RemoteDataProvider {
    private init(){}
    
    static func request(urlPath:String, bodyData:Data? = nil, _ completion:@escaping (Data?, Error?)->Void){
        guard let url = URL(string: urlPath) else {
            completion(nil, NetworkError.invalidUrl)
            return
        }
        var request = URLRequest(url: url)
        request.httpBody = bodyData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(nil, NetworkError.client)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        completion(nil, NetworkError.server)
                        return
                }
                if httpResponse.mimeType != nil && httpResponse.mimeType != "application/json" {
                    completion(nil, NetworkError.mimeType)
                    return
                }
                completion(data, nil)
                
            }
        }
        task.resume()
    }
}
