//
//  WeatherDayView.swift
//  Weather
//
//  Created by Kakarla.m on 06/07/24.
//

import SwiftUI

struct WeatherDayView: View {
    
    var weatherData:WeatherDetails
    
    var body: some View {
        VStack {
            Text(weatherData.formattedDate)
                .font(.title3)
                .foregroundStyle(.black)
            
            Image(systemName: weatherData.weather.weatherImageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
            Text("\(weatherData.temp ?? 24)°")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(.white)
        }
        .padding()

    }
}

