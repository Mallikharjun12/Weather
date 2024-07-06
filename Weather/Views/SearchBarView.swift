//
//  SearchBarView.swift
//  Weather
//
//  Created by Kakarla.m on 06/07/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text:String
    var locationBtnAction: (() -> ())?
    var searchBtnAction:(() -> ())?
    
    var body: some View {
        HStack(alignment:.top) {
            Button(action: {
                locationBtnAction?()
            }, label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .tint(Color(uiColor: .label))
            })
            
            TextField("Enter City Name...", text: $text)
                .foregroundStyle(Color.gray)
                .padding()
                .frame(width: .infinity, height: 40, alignment: .leading)
                .background(Color.blue)
                .border(Color.clear, width: 1)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            Button(action: {
                searchBtnAction?()
            }, label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .tint(Color(uiColor: .label))
            })
        }
        .padding()
    }
}

#Preview {
    SearchBarView(text: .constant("Vihayawada"))
}
