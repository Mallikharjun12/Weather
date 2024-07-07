//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Kakarla.m on 05/07/24.
//

import Foundation

enum Status {
    case none
    case loading
    case success
    case failure(Error)
}

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var currentWeather: WeatherDetails?
    @Published var forecastDetails: [WeatherDetails] = []
    @Published var isLoading = false
    @Published var searchText:String = ""

    private let service = NetworkManager()
    private var searchTimer:Timer?
    
    @Published var currentStatus:Status = .none
    @Published var forecastStatus:Status = .none
    
    
    func locationPressed() {
         // fetch current location
        
        // call method for current weather and forecast
    }
    
    
    func searchPressed() {
        fetchWeather(for: searchText, type: .current)
        fetchWeather(for: searchText, type: .forecast)
    }
    
    
    func fetchWeather(for city: String, type:RequestType) {
        
        switch type {
        case .current:
            self.currentStatus = .loading
            Task {
                do {
                    let weather = try await self.service.perform(WeatherRequest(cityName: city, type: .current), decodeTo: WeatherData.self)
                    DispatchQueue.main.async {
                        self.weatherData = weather
                        self.currentStatus = .success
                    }
                }
                catch {
                    self.currentStatus = .failure(error)
                }
                
            }
        case .forecast:
            self.forecastStatus = .loading
            Task {
                do {
                    let weather = try await self.service.perform(WeatherRequest(cityName: city, type: .forecast), decodeTo: WeatherData.self)
                    DispatchQueue.main.async {
                        self.forecastDetails = Array(weather.data.prefix(3))
                        self.forecastStatus = .success
                    }
                }
                catch {
                    self.forecastStatus = .failure(error)
                }
                
            }
        }
    }
}


