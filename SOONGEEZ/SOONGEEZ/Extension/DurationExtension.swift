//
//  DurationExtension.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/22/24.
//

import Foundation

extension String {
    func convertDuration() -> String {
        let pattern = "PT(\\d+H)?(\\d+M)?(\\d+S)?"
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        
        var hours = 0
        var minutes = 0
        var seconds = 0
        
        for match in matches {
            for rangeIndex in 1..<match.numberOfRanges {
                let range = match.range(at: rangeIndex)
                if range.length == 0 { continue }
                
                let componentString = (self as NSString).substring(with: range)
                let value = Int(componentString.dropLast())!
                
                if componentString.hasSuffix("H") {
                    hours = value
                } else if componentString.hasSuffix("M") {
                    minutes = value
                } else if componentString.hasSuffix("S") {
                    seconds = value
                }
            }
        }
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}

//// 사용 예시:
//let duration = "PT3M36S"
//let converted = duration.convertDuration()
//
//print(converted) // 출력: 3:36
