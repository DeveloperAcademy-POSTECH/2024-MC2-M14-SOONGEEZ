//
//  SearchBar.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/15/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                        isSearching = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 7, leading: 8, bottom: 7, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                    isSearching = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .font(.system(size: 17))
                }
            }
        }
        .padding(.horizontal)
    }
}
