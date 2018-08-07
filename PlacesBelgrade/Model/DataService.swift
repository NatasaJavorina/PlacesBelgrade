//
//  DataService.swift
//  PlacesBelgrade
//
//  Created by Natasa Javorina on 8/7/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import Foundation

class DataService {
    
    static let placesUrl = "https://demo2205443.mockable.io/locations-list"
    
    static func loadPlaces()  {
        if Reachability.isConnectedToNetwork() {
            let url = URL(string: DataService.placesUrl)!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if data != nil && error == nil {
                    do {
                        if let jsonRoot = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            if let jsonPlaces = jsonRoot["data"] as? [[String: Any]] {
                                DispatchQueue.main.async {
                                    CoreDataManager.shared.insertPlaces(dictArray: jsonPlaces)
                                }
                            }
                        }
                    } catch {
                        
                    }
                } else {
                    
                }
            }
            task.resume()
        }
    }
}
