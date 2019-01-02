//
//  TableSection.swift
//  PFLScoreboard
//
//  Created by Arkin Hill on 1/1/19.
//  Copyright © 2019 Arkin Hill. All rights reserved.
//

import Foundation

struct TableSection<SectionItem: Comparable & Hashable, RowItem>: Comparable {
    
    var sectionItem: SectionItem
    var rowItems: [RowItem]
    
    static func < (lhs: TableSection, rhs: TableSection) -> Bool {
        return lhs.sectionItem < rhs.sectionItem
    }
    
    static func == (lhs: TableSection, rhs: TableSection) -> Bool {
        return lhs.sectionItem == rhs.sectionItem
    }
    
    static func group(rowItems: [RowItem], by criteria: (RowItem) -> (SectionItem)) -> [TableSection] {
        // Creating tableView sections based on first day of month of each newsletter
        let groups = Dictionary(grouping: rowItems, by: criteria)
        return groups.map(TableSection.init(sectionItem: rowItems:)).sorted()
    }
}

// Video on how to use the TableSection struct generically across projects:
// https://www.ralfebert.de/ios-examples/uikit/uitableviewcontroller/grouping-sections/

