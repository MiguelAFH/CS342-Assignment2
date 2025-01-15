//
//  MedicationTests.swift
//  Assignment2Tests
//
//  Created by Miguel Fuentes on 1/13/25.
//

import Foundation
import Testing
@testable import Assignment2

struct MedicationTests {

    @Test func initializesCorrectly() async throws {
        // GIVEN a created medication.
        let date = Date()
        let medication = Medication(
            name: "Metoprolol",
            dose: "25 mg",
            route: "by mouth",
            frequency: "once daily",
            duration: "90 days",
            date: date
        )
        
        // THEN all of its properties are initialized correctly.
        #expect(medication.name == "Metoprolol")
        #expect(medication.dose == "25 mg")
        #expect(medication.route == "by mouth")
        #expect(medication.frequency == "once daily")
        #expect(medication.duration == "90 days")
        #expect(medication.date == date)
        #expect(medication.completed == false)
        #expect(medication.dateCompleted == nil)
    }
        
    
    @Test func printDescription() async throws {
        // GIVEN a created medication.
        let date = Date()
        let medication = Medication(
            name: "Metoprolol",
            dose: "25 mg",
            route: "by mouth",
            frequency: "once daily",
            duration: "90 days",
            date: date
        )
        
        // WHEN the medication description is called (for printing).
        let medicationDescription = medication.description
        
        // THEN the description should match the description structure.
        let expectedDescription = "Metoprolol 25 mg by mouth once daily for 90 days. Prescribed on \(date.description)."
        #expect(medicationDescription == expectedDescription)
    }
    
    @Test func printDescriptionMissingProperties() async throws {
        // GIVEN an empty medication.
        let date = Date()
        let medication = Medication(
            name: "",
            dose: "",
            route: "",
            frequency: "",
            duration: "",
            date: date
        )
        // WHEN the medication description is called (for printing).
        let medicationDescription = medication.description

        // THEN the description should match the description structure.
        let expectedDescription = "    for . Prescribed on \(date.description)."
        #expect(medicationDescription == expectedDescription)
    }
    
    @Test func completedSetsCompletedDate() async throws {
        let date = Date()
        var medication = Medication(
            name: "",
            dose: "",
            route: "",
            frequency: "",
            duration: "",
            date: date)
        medication.complete()
        #expect(medication.dateCompleted != nil)
    }

}
