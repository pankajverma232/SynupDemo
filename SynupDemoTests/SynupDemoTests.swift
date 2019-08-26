//
//  SynupDemoTests.swift
//  SynupDemoTests
//
//  Created by Pankaj Verma on 26/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import XCTest
@testable import SynupDemo

class SynupDemoTests: XCTestCase {
    var session: URLSession!
    override func setUp() {
        super.setUp()
        session = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        session = nil
        super.tearDown()
    }
    
    func testRemoteDataFetch() {
        // given
        let urlPath = Constants.urls.varients
        var statusCode: Int?
        var responseError: Error?
        let promise = expectation(description: "Status code: 200...299")
        
        let url = URL(string: urlPath)
        
        // when
        let dataTask = session!.dataTask(with: url!) { (data, response, error) in
            // then
            if let error = error {
                responseError = error
                return
            }
            else if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
                
                if let statusCodeRange = statusCode, (200...299).contains(statusCodeRange) {
                    statusCode = 200
                    promise.fulfill()
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 10) //wait for 10 seconds
        
        //Then
        XCTAssertNil(responseError?.localizedDescription)
        XCTAssertEqual(statusCode, 200)
    }
    
    
    
    func testResponseProvider(){
        let urlPath = Constants.urls.varients
        // The description parameter describes what you expect to happen.
        let promise = expectation(description: "response data")
        var responseData: HomeModel.Response?
        var responseError: Error?
        
        RemoteDataProvider.request(urlPath: urlPath) { (data, error) in
            if let error = error {
                responseError = error
                return
            }
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(HomeModel.Response.self, from: data!)
                responseData = response
                promise.fulfill()
            } catch let err {
                responseError = err
                return
            }
        }
        //wait for 10 seconds
        wait(for: [promise], timeout: 10)
        
        // then
        XCTAssertNil(responseError?.localizedDescription)
        XCTAssertNotNil(responseData)
        
    }
}
