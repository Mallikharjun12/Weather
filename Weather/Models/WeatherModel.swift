//
//  WeatherModel.swift
//  Weather
//
//  Created by Kakarla.m on 05/07/24.
//

import Foundation

import Foundation

struct WeatherData: Codable {
    let cityName: String?
    let countryCode: String?
    let lat: String?
    let lon: String?
    let stateCode: String?
    let timezone: String?
    let data: [WeatherDetails]

    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case countryCode = "country_code"
        case lat
        case lon
        case stateCode = "state_code"
        case timezone
        case data
    }
}

struct WeatherDetails: Codable,Identifiable {
    var id: UUID = UUID()
    let datetime: String?
    let temp: Double?
    let clouds: Int?
    let dewpt: Double?
    let maxTemp: Double?
    let minTemp: Double?
    let moonPhase: Double?
    let precip: Double?
    let pressure: Double?
    let humidity: Int?
    let visibility: Double?
    let weather: Weather
    let windSpeed: Double?
    let windDirection: String?
    
    // fields for forecast data
    let pop: Int?
    let slp: Double?
    let snow: Double?
    let snowDepth: Double?
    let uv: Double?
    let windGustSpeed: Double?
}

struct Weather: Codable {
    let description: String
    let code: Int
    
    var weatherImageName:String {
        switch code {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
