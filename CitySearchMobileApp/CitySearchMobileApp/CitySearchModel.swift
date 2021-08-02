//
//  CitySearchModel.swift
//  CitySearchMobileApp
//
//  Created by Abhinav Mandloi on 01/08/21.
//

import Foundation

struct CitySearchResponse: Decodable {
    
    let Cities: [City]
    
    enum CodingKeys: String, CodingKey {
        case Cities = "geonames"
    }
}

struct City: Decodable {
    
    let toponymName,
        adminName1,
        countryName: String
    
}
