//
//  SwiftUIView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/15/24.
//

import SwiftUI

struct SwiftUIView: View {
    let songs: [LastFinaleMusic] = [
        LastFinaleMusic(title: "노래 제목 1", artist: "가수 1", imageURL: URL(string: "https://example.com/image1.jpg")!),
        LastFinaleMusic(title: "노래 제목 2", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "Starlight", artist: "Muse", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!),
        LastFinaleMusic(title: "노래 제목 4", artist: "가수 2", imageURL: URL(string: "https://example.com/image2.jpg")!)
    ]
    
    var body: some View {
        ForEach(songs) { song in
            VStack(spacing: 9){
                HStack(spacing: 12){
                    AsyncImage(url: song.imageURL)
                        .frame(width: 44, height: 44)
                        .cornerRadius(11)
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("노래 제목")
                            .font(.system(size: 17))
                            .frame(width: 260, height: 22, alignment: .leading)
                        Text("가수")
                            .font(.system(size: 15))
                            .foregroundColor(.customGray)
                            .frame(width: 260, height: 20, alignment: .leading)
                    }
                    Text("길이")
                        .font(.system(size: 12))
                        .foregroundColor(.customGray)
                }
               Divider()
            }
        }
        
    }
}

#Preview {
    SwiftUIView()
}
