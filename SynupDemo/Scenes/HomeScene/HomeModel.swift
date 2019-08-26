//
//  HomeModel.swift
//  SynupDemo
//
//  Created by Pankaj Verma on 24/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//
//
//import Foundation
enum HomeModel{

    //MARK:- Request
    struct Request{}

    
    //MARK:- response
    struct Response : Codable {
        let variants : Variants?
        
        enum CodingKeys: String, CodingKey {
            
            case variants = "variants"
        }
    }
    
    struct Variants : Codable {
        let variant_groups : [Variant_groups]?
        let exclude_list : [[Exclude_list]]?
        
        enum CodingKeys: String, CodingKey {
            
            case variant_groups = "variant_groups"
            case exclude_list = "exclude_list"
        }
    }
    struct Variant_groups : Codable {
        let group_id : String?
        let name : String?
        let variations : [Variations]?
        
        enum CodingKeys: String, CodingKey {
            
            case group_id = "group_id"
            case name = "name"
            case variations = "variations"
        }
    }
    struct Variations : Codable {
        let name : String?
        let price : Int?
        let `default` : Int?
        let id : String?
        let inStock : Int?
        let isVeg: Int?
        
        enum CodingKeys: String, CodingKey {
            
            case name = "name"
            case price = "price"
            case `default` = "default"
            case id = "id"
            case inStock = "inStock"
            case isVeg = "isVeg"
        }
    }
    
    struct Exclude_list : Codable {
        let group_id : String?
        let variation_id : String?
        
        enum CodingKeys: String, CodingKey {
            
            case group_id = "group_id"
            case variation_id = "variation_id"
        }
    }

    
    //MARK:-  View model
    
    //associated with UI
    struct HomeViewModel{
        struct DisplayedVarient {
            var name:String?
            var price:Int?
            var selected:Bool?
            var id:String?
            var inStock:Bool?
            var isVeg:Bool?
        }
        struct ExcludedVarient {
            let groupId:String?
            let variationId:String?
        }

        struct Section {
            let groupId:String?
            let name:String?
            var rows:[DisplayedVarient]
        }
        var sections:[Section]
    }
}




