//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Kakarla.m on 05/07/24.
//

import Foundation
import CoreLocation

enum Status {
    case none
    case loading
    case success
    case failure(Error)
}

class WeatherViewModel:NSObject, ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var currentWeather: WeatherDetails?
    @Published var forecastDetails: [WeatherDetails] = []
    @Published var isLoading = false
    @Published var searchText:String = ""

    private let service = NetworkManager()
    private var searchTimer:Timer?
    
    @Published var currentStatus:Status = .none
    @Published var forecastStatus:Status = .none
    
    
    // for fetching current location
    let locationManager = CLLocationManager()
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    var city:String = ""
    func locationPressed() {
         // fetch current location
        locationManager.requestLocation()
        
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


extension WeatherViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            
            let geoCoder = CLGeocoder()
            
            geoCoder.reverseGeocodeLocation(location) {[weak self] placemarks, error in
                guard let self else {
                    return
                }
                guard let placemarks = placemarks, error == nil else {
                    return
                }
                print(placemarks.first?.locality)
                self.city = placemarks.first?.locality ?? ""
                
                self.fetchWeather(for:city , type: .current)
                self.fetchWeather(for: city, type: .forecast)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
