//
//  HomeInteractor.swift
//  SynupDemo
//
//  Created by Pankaj Verma on 24/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic {
    func getVarients(request:HomeModel.Request?)
    func getFilteredVarients()
}

class HomeInteractor: HomeBusinessLogic {
    var presenter:HomePresentationLogic?
    func getVarients(request:HomeModel.Request?){
        let varientsDataProvider = DataProviderFactory.shared.varientsDataProvider()
        varientsDataProvider.fetchVarients(nil) { (response, error) in
            
            if let response = response {
                self.presenter?.presentVarients(response: response)
            }else{
                self.presenter?.presentError(error: error)
            }
        }
    }
    
    func getFilteredVarients(){
        presenter?.presentFilteredResult(response: nil)
    }
}
