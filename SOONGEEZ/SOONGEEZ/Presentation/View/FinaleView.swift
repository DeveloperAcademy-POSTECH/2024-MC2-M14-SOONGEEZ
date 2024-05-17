//
//  FinaleView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI

struct FinaleView: View {
    var body: some View {
        
            HStack{
                Image("textLogo") //피날레로고
                    .resizable()
                    .scaledToFit()
                    .frame(width:69, height:21)
                    .padding(20)
                Spacer()
            }
            Spacer()
                .frame(height:30)
        
        VStack(alignment: .leading, spacing: 11){
            Text("종료시간")
                .fontWeight(.semibold)
                .font(.system(size:17))
                .padding(.leading, 56)
                .padding(.bottom, 5)
            
            Text("오전 08:45")
                .font(.system(size:34))
                .padding(.leading, 56)
            
           
            Path { path in
                        path.move(to: CGPoint(x: 56, y: 0)) // 선을 시작할 위치를 설정합니다.
                        path.addLine(to: CGPoint(x: 220, y: 0)) // 선으로 이어질 위치를 설정합니다.
                    }
                    .stroke(Color.black, lineWidth: 1)
                    .frame(height: 1)

            
            Text("피날레 곡")
                .fontWeight(.semibold)
                .font(.system(size:17))
                .padding(.leading, 56)
                .padding(.top, 29)
                .padding(.bottom, 9)
            
            ZStack{
                RoundedRectangle(cornerRadius:  16)
                    .fill(.thickMaterial)
                    .strokeBorder(Color.black)
                    .frame(width:282, height:341)
                    .padding(.leading, 56)
                
                VStack(spacing:0){
                
                    Image("recordAudio") //오디오이미지
                        .resizable()
                        .scaledToFit()
                        .frame(width:250, height:249)
//                        .padding(.bottom, 14)
                        .background{
                        RoundedRectangle(cornerRadius: 12)
                                .fill(Color.purple)
                        }
                     
                    
                        Text("피날레 곡을 선택해주세요")
                            .font(.system(size:17))
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                            .padding(.top, 14)
                
                          
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.gray)
                      
                    
                }.padding(.leading, 56)
            }
            
        }
        
    
        Button(action: {
            
        }, label: {
            HStack{
                Image(systemName: "play.fill")
                Text(" 플레이리스트 생성하고 재생")
            }.padding([.vertical],16.5)
             .padding([.horizontal],70.5)
             .background{
                 RoundedRectangle(cornerRadius: 12)
                         .fill(Color.gray)
             }
        }).padding(.top ,65)
       Spacer()
    }
}

#Preview {
    FinaleView()
}
