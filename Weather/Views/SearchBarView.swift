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
                Image(systemName: "paperplane.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            })
            
            TextField("Enter your desired Location", text: $text)
                .foregroundColor(Color.gray)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity, minHeight: 35, alignment: .leading)
                .padding(.horizontal, 6)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1.0))
                .background(Color.white)
                .padding(.trailing, 10)
                
                
            
            Button(action: {
                searchBtnAction?()
            }, label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            })
        }
        .padding()
    }
}

#Preview {
    SearchBarView(text: .constant("Vihayawada"))
}
