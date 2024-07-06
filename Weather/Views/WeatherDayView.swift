//
//  WeatherDayView.swift
//  Weather
//
//  Created by Kakarla.m on 06/07/24.
//

import SwiftUI

struct WeatherDayView: View {
    
    var weatherData:WeatherData?
   // @Binding var showDetails:Bool
    
    var body: some View {
        VStack {
          //  Text(weatherData.dateForForecast)
            Text("6/7")
                .font(.title3)
                .foregroundStyle(.black)
            
         //   Image(systemName: weatherData.weatherImageName)
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
          //  Text("\(weatherData.temp)°C")
            Text("26°C")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(.white)
        }
        .padding()
//        .popover(isPresented: $showDetails, content: {
//            WeatherDetailsView()
//        })
//        .onTapGesture {
//            showDetails = true
//        }
    }
}

#Preview {
    WeatherDayView()
}
