//
//  ContentView.swift
//  Weather
//
//  Created by Kakarla.m on 05/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    SearchBarView(text: $viewModel.searchText,
                                  locationBtnAction: viewModel.locationPressed,
                                  searchBtnAction: viewModel.searchPressed)
                    
                    // current details
                    VStack(spacing:2) {
                        
                        switch viewModel.currentStatus {
                        case .loading:
                            LoadingView(title: "Fetching Current Weather ")
                        case .success:
                            Text(viewModel.weatherData?.cityName ?? "Bengaluru")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .padding()
                            
                            VStack(spacing:8) {
                                Image(systemName: viewModel.weatherData?.data.first?.weather.weatherImageName ?? "cloud.sun.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                                
                                Text("\(viewModel.weatherData?.data.first?.temp ?? 27)°C")
                                    .font(.system(size: 50, weight: .regular))
                                    .foregroundStyle(.white)
                            }
                            .padding(.bottom, 75)
                        case .failure(let error):
                            Text("Unable to Fetch Current Weather Details \n \(error.localizedDescription)")
                        case .none:
                            EmptyView()
                        }
                        
                        
                        //Forecast details
                        switch viewModel.forecastStatus {
                        case .loading:
                            LoadingView(title: "Fetching weather forecast details")
                        case .success:
                            HStack(spacing:12) {
                                ForEach(viewModel.forecastDetails) { detail in
                                    NavigationLink {
                                        WeatherView(details: detail, cityName: viewModel.weatherData?.cityName ?? "")
                                    } label: {
                                        WeatherDayView(weatherData: detail)
                                    }

                                }
                            }
                        case .failure(let error):
                            Text("Unable to fetch weather forecast \n \(error.localizedDescription)")
                        case .none:
                            EmptyView()
                        }
                    }
                    
                    Spacer()
                }
          }
            
        }
    }
}

#Preview {
    ContentView()
}



struct LoadingView:View {
    
    var title:String
    
    var body: some View {
        ProgressView(title)
            .progressViewStyle(.circular)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tint(.black)
    }
}
