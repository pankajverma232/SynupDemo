//
//  HomePresenter.swift
//  SynupDemo
//
//  Created by Pankaj Verma on 24/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import Foundation


protocol HomePresentationLogic {
    func presentVarients(response:HomeModel.Response?)
    func presentError(error:Error?)
    func presentFilteredResult(response:HomeModel.Response?)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController:HomeDisplayLogic?
    
    
    var sectios: [HomeModel.HomeViewModel.Section] = []
    var excludedVarients: [[HomeModel.HomeViewModel.ExcludedVarient]] = []

    func presentVarients(response:HomeModel.Response?) {
        
        //reset
         sectios = []
         excludedVarients = []
        
        if let varients = response?.variants{
            if let group = varients.variant_groups{
                for variant in  group {
                    var section = HomeModel.HomeViewModel.Section(groupId: variant.group_id, name: variant.name, rows: [])
                    if let variations = variant.variations {
                        for variation in variations {
                            let displayedVariant = HomeModel.HomeViewModel.DisplayedVarient(name: variation.name, price: variation.price, selected: variation.default?.boolValue, id: variation.id, inStock: variation.inStock?.boolValue, isVeg: variation.isVeg?.boolValue)
                            section.rows.append(displayedVariant)
                        }
                    }
                    sectios.append(section)
                }
            }
            
            if let exclude_list = varients.exclude_list {
                for excludedList in exclude_list {
                    var excludedVarient:[HomeModel.HomeViewModel.ExcludedVarient] = []
                    for excluded in excludedList {
                        let excludedV = HomeModel.HomeViewModel.ExcludedVarient(groupId: excluded.group_id, variationId: excluded.variation_id)
                        excludedVarient.append(excludedV)
                    }
                    excludedVarients.append(excludedVarient)
                }
            }
        }
        let viewModel = HomeModel.HomeViewModel(sections: sectios)
        viewController?.displayVarients(viewModel: viewModel)
    }
    
    
    func presentError(error:Error?){
        viewController?.displayError(err: error?.localizedDescription ?? Constants.Strings.HomeScene.noResponse)
    }
    
    //Filtered variants
    func presentFilteredResult(response:HomeModel.Response?){
        
        var filteredSectios: [HomeModel.HomeViewModel.Section] = sectios

        for excludedVariantsForGroup in excludedVarients{
            for variation in excludedVariantsForGroup {
                if let groupId = variation.groupId, let variationId = variation.variationId {
                    
                    if let sectionIndex = filteredSectios.firstIndex(where: {$0.groupId == groupId}) {
                        filteredSectios[sectionIndex].rows.removeAll { (variation) -> Bool in
                            return variation.id == variationId
                        }
                    }
                
                }
            }
        }
        let viewModel = HomeModel.HomeViewModel(sections: filteredSectios)
        viewController?.displayVarients(viewModel: viewModel)
    }
}

