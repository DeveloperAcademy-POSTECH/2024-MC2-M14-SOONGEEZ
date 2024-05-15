//
//  SelectMusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct SelectMusicView: View {
    
    @State private var searchText = ""
    
    let songs: [Song] = [
        Song(title: "노래 제목 1", artist: "가수 1", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Song(title: "노래 제목 2", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Song(title: "Starlight", artist: "Muse", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Song(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Song(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        Song(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!)
    ]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17)
    ]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading,
                   spacing: 8){
                Text("피날레 곡")
                    .padding(.leading, 20)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Text("오늘의 피날레를 장식할 곡을 선택해 주세요.")
                    .padding(.leading, 20)
                    .font(.system(size: 17))
                
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 8, trailing: 0))
                
                Text("최근 선택한 곡")
                    .padding(.leading, 20)
                    .font(.system(size: 14))
            }
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(songs) { song in
                    VStack(alignment: .leading) {
                        AsyncImage(url: song.imageURL)
                            .frame(width: 168, height: 168)
                            .cornerRadius(16)
                            .padding(.bottom, 4)
                        
                        Text(song.title)
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                        
                        Text(song.artist)
                            .font(.system(size: 12))
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}


#Preview {
    SelectMusicView()
}
