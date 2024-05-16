//
//  MusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct MusicView: View {
    var body: some View {
        ZStack{
            //Image("") //백그라운드 이미지 들어갈 것
            
            VStack(spacing:0){
                
                TopLogo
                
                CurrentOrder
                
                CurrentPlayingSong
                
                Spacer()
            }
        }
        
    }
}

extension MusicView {
    var TopLogo: some View {
        HStack{
            Image("textLogo")//텍스트 로고
                .resizable()
                .scaledToFit()
                .frame(width:69, height: 21)
                .padding([.top], 15)
                .padding([.bottom], 24)
                .padding([.horizontal], 20)
            Spacer()
        }
    }
    
    var CurrentOrder: some View {
        HStack{
            Text("오늘의 플레이리스트 \n첫번째 곡이에요􀑪") //(data?)첫번째 곡 부분은 계속 업데이트 되게 해야함
                .font(.system(size: 28, weight:.bold))//semibold로하면 피그마랑 묘하게 안맞음
                .lineSpacing(5)
                .padding([.leading],20)
                .padding([.bottom], 24)
            Spacer()
        }
    }
    
    var CurrentPlayingSong: some View {
        VStack(spacing:0){
            VStack(spacing:0){
//                Image("")
//                .resizable
//                .scaledToFit
//                .frame(width:305, height:305)
                VStack(spacing:12){//songinfo
                    HStack{
                        Text("노래제목")//data: 노래제목
                            .font(.system(size: 24, weight:.semibold))
                        Spacer()
                    }
                    HStack{
                        Text("가수")//data: 가수
                            .font(.system( size: 20))
                        Spacer()
                    }
                }.padding([.bottom], 20)
                
                VStack(spacing:0){//songLength
                    //재생바
                    HStack{
                        Text("현재까지 재생된 시간")//data: 현재 재생시간
                            .font(.system( size: 16))
                        Spacer()
                        Text("총 길이")//data: 총 재생길이
                            .font(.system( size: 16))
                    }
                }
            }
        }
        .padding(24)
    
        .background(Color.orange)
        .padding([.horizontal],20)
        
    }
            
   
    //여기부터 추가
}


#Preview {
    MusicView()
}
