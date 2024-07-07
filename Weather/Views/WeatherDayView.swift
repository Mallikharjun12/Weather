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
                .foregroundStyle(.white)
            
            Image(systemName: weatherData.weather.weatherImageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .tint(.black)
                .frame(width: 60, height: 60)
            
            Text("\(weatherData.temp?.roundDouble() ?? "24")°")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(.white)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.blue, lineWidth: 1.0)
        }
        .padding()

    }
}

