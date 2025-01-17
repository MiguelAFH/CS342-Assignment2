//
//  Medications.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/16/25.
//

import Foundation

@Observable
class Medications: RandomAccessCollection {
    var medicationList: [Medication] = []
    
    init(medicationList: [Medication] = []) {
        self.medicationList = medicationList
    }
    
    var isEmpty: Bool {
        return medicationList.isEmpty
    }
    
    var count: Int {
        return medicationList.count
    }
    
    // Subscript to access elements
    subscript(position: Int) -> Medication {
        return medicationList[position]
    }
    
    // Required by RandomAccessCollection
    var startIndex: Int { medicationList.startIndex }
    var endIndex: Int { medicationList.endIndex }
    
    func index(after i: Int) -> Int {
        return medicationList.index(after: i)
    }
    
    func index(before i: Int) -> Int {
        return medicationList.index(before: i)
    }
}
