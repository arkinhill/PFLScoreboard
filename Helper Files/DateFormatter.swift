//
//  DateFormatter.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 12/19/18.
//  Copyright © 2018 Arkin Hill. All rights reserved.
//

import Foundation

extension Date {
    
    var asString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: self)
    }
}
