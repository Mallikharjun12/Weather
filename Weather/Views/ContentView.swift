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
            VStack {
                SearchBarView(text: $viewModel.searchText,
                              locationBtnAction: viewModel.locationPressed,
                              searchBtnAction: viewModel.searchPressed)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
