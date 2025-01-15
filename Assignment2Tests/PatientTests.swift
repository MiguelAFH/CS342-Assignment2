//
//  PatientTests.swift
//  Assignment2Tests
//
//  Created by Miguel Fuentes on 1/13/25.
//

import Foundation
import Testing
@testable import Assignment2

struct PatientTests {

    @Test func setAllValues() async throws {
        // GIVEN a new patient is added
        let birthDate = Date()
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive
        )
        // THEN all values should be set
        #expect(patient.firstName == "first")
        #expect(patient.lastName == "last")
        #expect(patient.birthDate == birthDate)
        #expect(patient.height == 180)
        #expect(patient.weight == 70)
        #expect(patient.medications.isEmpty)
        #expect(patient.bloodType == BloodType.aPositive)
        #expect(patient.id != nil)
    }
    
    @Test func differentMedicalRecordNumber() async throws {
        // GIVEN two different patients
        let birthDate = Date()
        let patient1 = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive
        )
        
        let patient2 = Patient(
            firstName: "first2",
            lastName: "last2",
            birthDate: birthDate,
            height: 160,
            weight: 60,
            bloodType: BloodType.aPositive
        )
        
        // THEN their medical record numbers are different.
        #expect(patient1.id != patient2.id)
            
    }
    
    @Test func doNotSetBloodType() async throws {
        // GIVEN a new patient is added with no blood type
        let birthDate = Date()
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: nil
        )
        // THEN the only nil value should be the blood type
        #expect(patient.firstName == "first")
        #expect(patient.lastName == "last")
        #expect(patient.birthDate == birthDate)
        #expect(patient.height == 180)
        #expect(patient.weight == 70)
        #expect(patient.medications.isEmpty)
        #expect(patient.bloodType == nil)
    }
    
    @Test func doNotSetMedications() async throws {
        // GIVEN a new patient is added with no medications
        let birthDate = Date()
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive
        )
        // THEN the medications list should be empty
        #expect(patient.firstName == "first")
        #expect(patient.lastName == "last")
        #expect(patient.birthDate == birthDate)
        #expect(patient.height == 180)
        #expect(patient.weight == 70)
        #expect(patient.medications.isEmpty)
        #expect(patient.bloodType == BloodType.aPositive)
    }
    
    @Test func returnsFullNameNewBorn() async throws {
        // GIVEN a patient with first name, last name and birh date of a new born
        let birthDate = Date()
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive
        )
        // WHEN the full name is returned
        let fullName = patient.fullName()
        
        // THEN it is formatted as "lastName, firstName (age in year)"
        #expect(fullName == "last, first")
    }
    
    @Test func returnsFullName10YearOld() async throws {
        // GIVEN a patient with first name, last name and birh date of a 10 year old
        let now = Date()
        let birthDate = Calendar.current.date(byAdding: .year, value: -10, to: now)!
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive
        )
        // WHEN the full name is returned
        let fullName = patient.fullName()
        
        // THEN it is formatted as "lastName, firstName (age in year)"
        #expect(fullName == "last, first")
    }
    
    @Test func returnsEmptyMedicationsWhenNoMedicationsArePresent() async throws {
        // GIVEN a patient with no medications history
        let birthDate = Date()
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive
        )
        // WHEN the list of ongoing medications is retrieved
        let ongoingMedications = patient.ongoingMedications
        
        // THEN the medications list is empty
        #expect(ongoingMedications.isEmpty)
    }
    
    @Test func returnsEmptyMedicationsWhenNoOngoingMedicationsArePresent() async throws {
        // GIVEN a patient with no ongoing medications history
        let birthDate = Date()
        let medications = Medications(medicationList: [
            Medication(
                name: "test name",
                dose: "test dose",
                route: "test route",
                frequency: "test frequency",
                duration: "test duration",
                date: Date(),
                completed: true
            )
        ])
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive,
            medications: medications
        )
        // WHEN the list of ongoing medications is retrieved
        let ongoingMedications = patient.ongoingMedications
        
        // THEN the medications list is empty
        #expect(ongoingMedications.isEmpty)
    }
    
    @Test func returnsMedicationsWhenOngoingMedicationsArePresent() async throws {
        // GIVEN a patient with 1 ongoing medication
        let birthDate = Date()
        let medications = Medications(medicationList: [
            Medication(
                name: "test name",
                dose: "test dose",
                route: "test route",
                frequency: "test frequency",
                duration: "test duration",
                date: Date()
            ),
            Medication(
                name: "test name2",
                dose: "test dose2",
                route: "test route2",
                frequency: "test frequency2",
                duration: "test duration2",
                date: Date(),
                completed: true
            )
        ])
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: birthDate,
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive,
            medications: medications
        )
        // WHEN the list of ongoing medications is retrieved
        let ongoingMedications = patient.ongoingMedications
        
        // THEN the medications list contains the activate medications.
        #expect(ongoingMedications.count == 1)
        #expect(ongoingMedications[0].name == medications[0].name)
    }
    
    @Test func returnsMedicationsInChronologicalOrder() async throws {
        // GIVEN a patient with 2 ongoing medications
        let now = Date()
        let medicationDate1 = Calendar.current.date(byAdding: .day, value: -5, to: now)!
        let medicationDate2 = Calendar.current.date(byAdding: .day, value: -10, to: now)!
        let medications = Medications(medicationList: [
            Medication(
                name: "test name",
                dose: "test dose",
                route: "test route",
                frequency: "test frequency",
                duration: "test duration",
                date: medicationDate1
            ),
            Medication(
                name: "test name2",
                dose: "test dose2",
                route: "test route2",
                frequency: "test frequency2",
                duration: "test duration2",
                date: medicationDate2
            )
        ])
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive,
            medications: medications
        )
        // WHEN the list of ongoing medications is retrieved
        let ongoingMedications = patient.ongoingMedications
        
        // THEN the medications list contains the activate medications in chronological order.
        #expect(ongoingMedications.count == 2)
        #expect(ongoingMedications[0].name == medications[1].name)
        #expect(ongoingMedications[1].name == medications[0].name)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsUnknown() {
        // GIVEN a patient with unknown blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: nil
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        
        // THEN the blood donor types list is empty
        #expect(donorTypes.isEmpty)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsAPositive() {
        // GIVEN a patient with AB+ blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.aPositive
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        let expectedDonorTypes: Set<BloodType> = [
            .aPositive,
            .aNegative,
            .oPositive,
            .oNegative,
        ]
        // THEN the blood donor types list is not empty
        #expect(donorTypes == expectedDonorTypes)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsANegative() {
        // GIVEN a patient with AB+ blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.aNegative
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        let expectedDonorTypes: Set<BloodType> = [
            .aNegative,
            .oNegative
        ]
        // THEN the blood donor types list is not empty
        #expect(donorTypes == expectedDonorTypes)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsBPositive() {
        // GIVEN a patient with AB+ blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.bPositive
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        let expectedDonorTypes: Set<BloodType> = [
            .bPositive,
            .bNegative,
            .oPositive,
            .oNegative
        ]
        // THEN the blood donor types list is not empty
        #expect(donorTypes == expectedDonorTypes)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsBNegative() {
        // GIVEN a patient with AB+ blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.bNegative
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        let expectedDonorTypes: Set<BloodType> = [
            .bNegative,
            .oNegative
        ]
        // THEN the blood donor types list is not empty
        #expect(donorTypes == expectedDonorTypes)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsOPositive() {
        // GIVEN a patient with AB+ blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.oPositive
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        let expectedDonorTypes: Set<BloodType> = [
            .oPositive,
            .oNegative
        ]
        // THEN the blood donor types list is not empty
        #expect(donorTypes == expectedDonorTypes)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsONegative() {
        // GIVEN a patient with AB+ blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.oNegative
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        let expectedDonorTypes: Set<BloodType> = [
            .oNegative
        ]
        // THEN the blood donor types list is not empty
        #expect(donorTypes == expectedDonorTypes)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsABPositive() {
        // GIVEN a patient with AB+ blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.abPositive
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        let expectedDonorTypes: Set<BloodType> = [
            .aPositive,
            .aNegative,
            .bPositive,
            .bNegative,
            .oPositive,
            .oNegative,
            .abPositive,
            .abNegative
        ]
        // THEN the blood donor types list is not empty
        #expect(donorTypes == expectedDonorTypes)
    }
    
    @Test func returnsEmptyBloodDonorTypesIfBloodTypeIsABNegative() {
        // GIVEN a patient with AB+ blood type
        let patient = Patient(
            firstName: "first",
            lastName: "last",
            birthDate: Date(),
            height: 180,
            weight: 70,
            bloodType: BloodType.abNegative
        )
        // WHEN the blood donor types are computed
        let donorTypes = patient.bloodDonorTypes()
        let expectedDonorTypes: Set<BloodType> = [
            .aNegative,
            .bNegative,
            .oNegative,
            .abNegative
        ]
        // THEN the blood donor types list is not empty
        #expect(donorTypes == expectedDonorTypes)
    }

}
