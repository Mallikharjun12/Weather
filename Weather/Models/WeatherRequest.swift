//
//  WeatherRequest.swift
//  Weather
//
//  Created by Kakarla.m on 05/07/24.
//

import Foundation

enum Constants {
    static let key = "6202474398ad4b7a99cf54008b7c3020"
}

enum RequestType {
    case current
    case forecast
}

struct WeatherRequest:NetworkRequest {
    
    var cityName:String
    var type:RequestType
    
    
    var method: HTTPMethod = .get
    
    var path:String {
        switch type {
        case .current:
            return "current"
        case .forecast:
            return "forecast/daily"
        }
    }
    
    var queryParams: [String : String]? {
        var dict = [String:String]()
        dict["city"] = cityName
        dict["key"] = Constants.key
        return dict
    }
}
