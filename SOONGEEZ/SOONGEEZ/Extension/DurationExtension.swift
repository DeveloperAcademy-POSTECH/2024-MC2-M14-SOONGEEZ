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

extension Int {
    func convertIntDuration() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d분 %02d초", minutes, seconds)
    }
}

extension String {
    func convertToSeconds() -> Int {
        let components = self.split(separator: ":").map(String.init)
        guard components.count == 2,
              let minutes = Int(components[0]),
              let seconds = Int(components[1]) else {
            return 0
        }
        return minutes * 60 + seconds
    }
}



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
