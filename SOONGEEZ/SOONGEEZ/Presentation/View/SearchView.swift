//
//  SearchView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/15/24.
//

import SwiftUI
 
struct SearchView: View {
    let array = [
        "조세연", "조세연1", "조세연2", "조세연3", "조세연4", "조세연5"
    ]
    
    @State private var searchText = ""
    
    var body: some View {
            VStack {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                List {
                    ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in Text(searchText)
                    }
                } //리스트의 스타일 수정
                .listStyle(PlainListStyle())
                  //화면 터치시 키보드 숨김
                .onTapGesture {
                }
            }
    }
}



#Preview {
    SearchView()
}
