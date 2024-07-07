//
//  WeatherDetailsView.swift
//  Weather
//
//  Created by Kakarla.m on 07/07/24.
//

import SwiftUI

struct WeatherView: View {
    
    var details: WeatherDetails
    var cityName:String
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(cityName)
                        .bold()
                        .foregroundStyle(.white)
                        .font(.title)
                    
                    Text(details.formattedDate)
                        .fontWeight(.light)
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: details.weather.weatherImageName)
                                .font(.system(size: 40))
                                .foregroundStyle(.white)
                                .tint(.white)
                            
                            Text(details.weather.description)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text((details.temp?.roundDouble() ?? "") + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        WeatherRow(image: "thermometer", name: "Min temp", value: ((details.min_temp?.roundDouble() ?? "") + ("°")))
                        Spacer()
                        WeatherRow(image: "thermometer", name: "Max temp", value: ((details.max_temp?.roundDouble() ?? "") + "°"))
                    }
                    
                    HStack {
                        WeatherRow(image: "wind", name: "Wind speed", value: ((details.wind_spd?.roundDouble() ?? "") + " m/s"))
                        Spacer()
                        WeatherRow(image: "humidity", name: "Humidity", value: "\(details.rh ?? 34)%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
    }
}


struct WeatherRow: View {
    var image: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: image)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)

            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}



