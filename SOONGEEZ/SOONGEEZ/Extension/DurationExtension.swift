//
//  DurationExtension.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/22/24.
//



extension String {
    func convertDuration() -> String {
        guard let durationInSeconds = Int(self) else { return "변환 실패" }
        let minutes = durationInSeconds / 60
        let seconds = durationInSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//// 사용 예시
//let formattedDuration = videoInfo.duration.convertDuration()
//print(formattedDuration) // "MM:SS" 형식으로 출력



//import Foundation
//
//// Int 타입 확장
//extension Int {
//    // 초(second)를 입력받아 "MM:SS" 형식의 문자열로 변환하는 함수
//    func convertDuration() -> String {
//        let minutes = self / 60
//        let seconds = self % 60
//        // String(format:)를 사용하여 두 자리 숫자 형식을 강제합니다.
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//}

//// 사용 예시
//let duration = 215
//print(duration.toMinutesSeconds()) // 출력: "03:35"


//extension String {
//    func convertDuration() -> String {
//        let pattern = "PT(\\d+H)?(\\d+M)?(\\d+S)?"
//        let regex = try! NSRegularExpression(pattern: pattern)
//        let matches = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
//        
//        var hours = 0
//        var minutes = 0
//        var seconds = 0
//        
//        for match in matches {
//            for rangeIndex in 1..<match.numberOfRanges {
//                let range = match.range(at: rangeIndex)
//                if range.length == 0 { continue }
//                
//                let componentString = (self as NSString).substring(with: range)
//                let value = Int(componentString.dropLast())!
//                
//                if componentString.hasSuffix("H") {
//                    hours = value
//                } else if componentString.hasSuffix("M") {
//                    minutes = value
//                } else if componentString.hasSuffix("S") {
//                    seconds = value
//                }
//            }
//        }
//        
//        if hours > 0 {
//            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
//        } else {
//            return String(format: "%d:%02d", minutes, seconds)
//        }
//    }
//}
//
//
