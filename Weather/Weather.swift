//
//  Weather.swift
//  Weather
//
//  Created by Lou Allen Uy Sison on 11/22/21.
//

import Foundation

public struct Weather {
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    
    init(response: APIResponse) {
        
        let today = response.data.first
        
        city = "\(response.city_name), \(response.country_code)"
        temperature = "\(Double(today?.temp ?? 0.0))"
        description = today?.weather.description ?? ""
        iconName = today?.weather.icon ?? "c01d"
    }
}
