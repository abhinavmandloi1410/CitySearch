//
//  CitySearchService.swift
//  CitySearchMobileApp
//
//  Created by Abhinav Mandloi on 01/08/21.
//

import Foundation

struct URLContants {
    static let URL: String = "https://secure.geonames.org/searchJSON?"
    static let SEARCH_TEXT: String = "name_startsWith="
    static let MAX_ROW: String = "&maxRows="
    static let USERNAME: String = "&username="
}

struct CitySearchResource {
    
    func serachCities(with citySearchText: String,
                      maxRow: Int,
                      userName: String,
                      completionHandler: @escaping (CitySearchResponse?) -> ()) {
        
        guard let citySearchURLString = (URLContants.URL + URLContants.SEARCH_TEXT + citySearchText + URLContants.MAX_ROW + "\(maxRow)" + URLContants.USERNAME + userName).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let citySearchUrl = URL(string: citySearchURLString)!
        
        URLSession.shared.dataTask(with: citySearchUrl) { (data, response, error) in
            
            if(error == nil && data != nil)
            {
                do
                {
                    let planetResponse = try JSONDecoder().decode(CitySearchResponse.self, from: data!)
                    
                    completionHandler(planetResponse)
                }
                catch let error {
                    print(error)
                }
            }
            
        }.resume()
        
    }
    
}
