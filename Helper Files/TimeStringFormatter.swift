//
//  TimeStringFormatter.swift
//  PFL
//
//  Created by Arkin Hill on 1/10/19.
//  Copyright © 2019 Arkin Hill. All rights reserved.
//

import Foundation

class TimeStringFormatter {
    
    static let shared = TimeStringFormatter()
    
    func timeString(time: TimeInterval) -> [Character] {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let string = String(format: "%02i%02i", minutes, seconds)
        var newString: [Character] = []
        for character in string {
            newString.append(character)
        }
        return newString
    }
}
