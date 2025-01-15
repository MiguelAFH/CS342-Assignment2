//
//  Medication.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/13/25.
//

import Foundation


/**
    `Medication` represents a medication prescribed by a doctor to a patient.
    It includes information about the medication's name, dose, route of administration,
    frequency of administration, duration of the treatment, and the date of prescription.

    - `name`: The name of the medication.
    - `dose`: The amount of medication to be taken.
    - `route`: The method by which the medication is administered.
    - `frequency`: How often the medication is to be taken.
    - `duration`: The length of time the medication is prescribed to be taken.
    - `date`: The date the medication was prescribed.
    - `completed`: Whether the medication is completed or not.
    - `dateCompleted`: The data in which the medication was completed.
 */
struct Medication: CustomStringConvertible, Identifiable {
    let id: UUID = UUID()
    let name: String
    let dose: String
    let route: String
    let frequency: String
    let duration: String
    let date: Date
    var completed: Bool = false
    var dateCompleted: Date? = nil
    
    var description: String {
        return "\(name) \(dose) \(route) \(frequency) for \(duration). Prescribed on \(date)."
    }
    
    /**
        Sets the medication as completed and `dateCompleted` as the current date.
     */
    mutating func complete() {
        completed = true
        dateCompleted = Date()
    }
}

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

