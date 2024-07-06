//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Kakarla.m on 05/07/24.
//

import Foundation

enum Status {
    case loading
    case success
    case failure(Error)
}

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var currentWeather: WeatherDetails?
    @Published var forecastDetails: [WeatherDetails] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText:String = ""

    private let service = NetworkManager()
    private var searchTimer:Timer?
    
    @Published var currentStatus:Status = .loading
    @Published var forecastStatus:Status = .loading
    
    
    func locationPressed() {
        
    }
    
    
    func searchPressed() {
        
    }
    
    
    func fetchWeather(for city: String, type:RequestType) {
        
        switch type {
        case .current:
            self.currentStatus = .loading
            Task {
                do {
                    let weather = try await self.service.perform(WeatherRequest(cityName: city, type: .current), decodeTo: WeatherData.self)
                    self.weatherData = weather
                    self.currentStatus = .success
                }
                catch {
                    self.errorMessage = error.localizedDescription
                    self.currentStatus = .failure(error)
                }
                
            }
        case .forecast:
            self.forecastStatus = .loading
            Task {
                do {
                    let weather = try await self.service.perform(WeatherRequest(cityName: city, type: .forecast), decodeTo: WeatherData.self)
                    self.forecastDetails = weather.data
                    self.currentStatus = .success
                }
                catch {
                    self.errorMessage = error.localizedDescription
                    self.currentStatus = .failure(error)
                }
                
            }
        }
    }
}

/*
 Task {
     do {
        let weather = try await service.perform(WeatherRequest(cityName: city, type: .current), decodeTo: WeatherData.self)
     }
     catch {
         self.errorMessage = error.localizedDescription
     }
     
 }
 */
