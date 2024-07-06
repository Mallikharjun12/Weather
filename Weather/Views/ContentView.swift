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
                        Text("Addanki")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .padding()
                        
                        VStack(spacing:8) {
                            Image(systemName: "cloud.sun.fill")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                            
                            Text("37°C")
                                .font(.system(size: 50, weight: .regular))
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, 75)
                        
                        HStack(spacing:12) {
                            ForEach(0..<3) { num in
                                WeatherDayView()
                            }
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
