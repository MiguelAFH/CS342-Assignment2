//
//  ContentViewUITests.swift
//  ContentViewUITests
//
//  Created by Miguel Fuentes on 1/13/25.
//

import XCTest
@testable import Assignment2

final class ContentViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    // Helper function to wait for element existence
    private func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 5) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = expectation(for: predicate, evaluatedWith: element)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
    
    // MARK: - ContentView Tests
    
    func testContentViewInitialState() throws {
        // Wait for and verify navigation title
        let navBar = app.navigationBars["Patients"]
        XCTAssertTrue(waitForElement(navBar))
        
        // Wait for and verify search bar
        let searchField = app.textFields["Search"]
        XCTAssertTrue(waitForElement(searchField))
        
        // Wait for and verify add patient button
        let addButton = app.buttons["Add Patient"]
        XCTAssertTrue(waitForElement(addButton))
    }
    
    // MARK: - Patient Search Bar Tests
    
    func testPatientListFiltering() throws {
        addPatient(firstName: "TestFirst1", lastName: "TestLast1")
        addPatient(firstName: "TestFirst2", lastName: "TestLast2")
        
        // Wait for and interact with search field
        let searchField = app.textFields["Search"]
        XCTAssertTrue(waitForElement(searchField))
        searchField.tap()
        searchField.typeText("TestLast1")
        app.keyboards.buttons["Return"].tap()
        
        
        // Wait for filtered results
        let patient1Text = app.staticTexts["TestLast1, TestFirst1"]
        let patient2Text = app.staticTexts["TestLast2, TestFirst2"]
        XCTAssertTrue(waitForElement(patient1Text))
        XCTAssertFalse(patient2Text.exists)
    }
    
    // MARK: - Add Patient Tests
    
    func testAddPatientFlow() throws {
        // Tap add patient button after waiting
        let addButton = app.buttons["Add Patient"]
        XCTAssertTrue(waitForElement(addButton))
        addButton.tap()
        
        // Wait for and verify add patient sheet elements
        let firstNameField = app.textFields["First Name"]
        let lastNameField = app.textFields["Last Name"]
        let heightField = app.textFields["Height (cm)"]
        let weightField = app.textFields["Weight (kg)"]
        let birthDateText = app.staticTexts["Birth Date"]
        let bloodTypeText = app.staticTexts["Blood Type"]
        
        XCTAssertTrue(waitForElement(firstNameField))
        XCTAssertTrue(waitForElement(lastNameField))
        XCTAssertTrue(waitForElement(heightField))
        XCTAssertTrue(waitForElement(weightField))
        XCTAssertTrue(waitForElement(birthDateText))
        XCTAssertTrue(waitForElement(bloodTypeText))
        
        // Fill form fields
        firstNameField.tap()
        firstNameField.typeText("Test")
        
        lastNameField.tap()
        lastNameField.typeText("Patient")
        
        // Wait for and interact with date picker
        let datePicker = app.datePickers["Birth Date"]
        XCTAssertTrue(waitForElement(datePicker))
        datePicker.tap()
        
        let dayButton = app.staticTexts["20"]
        XCTAssertTrue(waitForElement(dayButton))
        dayButton.tap()
        
        let monthYearButton = app.staticTexts["January 2025"]
        XCTAssertTrue(waitForElement(monthYearButton))
        monthYearButton.tap()
        
        let monthWheel = app.pickerWheels.element(boundBy: 0)
        let yearWheel = app.pickerWheels.element(boundBy: 1)
        XCTAssertTrue(waitForElement(monthWheel))
        XCTAssertTrue(waitForElement(yearWheel))
        
        monthWheel.adjust(toPickerWheelValue: "May")
        yearWheel.adjust(toPickerWheelValue: "2002")
        
        let dismissRegion = app.buttons["PopoverDismissRegion"]
        XCTAssertTrue(waitForElement(dismissRegion))
        dismissRegion.tap()
        
        // Fill remaining fields
        heightField.tap()
        heightField.typeText("170")
        
        weightField.tap()
        weightField.typeText("70")
        
        // Save patient
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(waitForElement(saveButton))
        saveButton.tap()
        
        // Wait for and verify patient in list
        let patientNameText = app.staticTexts["Patient, Test"]
        let patientAgeText = app.staticTexts["Age: 22"]
        XCTAssertTrue(waitForElement(patientNameText))
        XCTAssertTrue(waitForElement(patientAgeText))
    }
    
    // MARK: - Navigation Tests
    
    func testPatientDetailNavigation() throws {
        addPatient(firstName: "TestFirst", lastName: "TestLast")
        
        // Wait for and tap patient row
        let patientRow = app.staticTexts["TestLast, TestFirst"]
        XCTAssertTrue(waitForElement(patientRow))
        patientRow.tap()
        
        // Wait for and verify navigation
        let detailNavBar = app.navigationBars["Patient Details"]
        XCTAssertTrue(waitForElement(detailNavBar))
    }
    
    // MARK: - Medication Tests
    
    func testAddMedication() throws {
        addPatient(firstName: "TestFirst", lastName: "TestLast")
        
        // Navigate to medications view
        let patientRow = app.staticTexts["TestLast, TestFirst"]
        XCTAssertTrue(waitForElement(patientRow))
        patientRow.tap()
        
        let medicationsText = app.staticTexts["Medications"]
        XCTAssertTrue(waitForElement(medicationsText))
        medicationsText.tap()
        
        // Wait for and tap add medication button
        let addMedButton = app.buttons["Add Medication"]
        XCTAssertTrue(waitForElement(addMedButton))
        addMedButton.tap()
        
        // Wait for and fill medication form
        let medicationNameField = app.textFields["Medication Name"]
        let medicationDoseField = app.textFields["Medication Dose"]
        let medicationRouteField = app.textFields["Medication Route"]
        let medicationFrequencyField = app.textFields["Medication Frequency"]
        let medicationDurationField = app.textFields["Medication Duration"]
        
        XCTAssertTrue(waitForElement(medicationNameField))
        XCTAssertTrue(waitForElement(medicationDoseField))
        XCTAssertTrue(waitForElement(medicationRouteField))
        XCTAssertTrue(waitForElement(medicationFrequencyField))
        XCTAssertTrue(waitForElement(medicationDurationField))
        
        medicationNameField.tap()
        medicationNameField.typeText("Test Medication")
        
        medicationDoseField.tap()
        medicationDoseField.typeText("Test Dose")
        
        medicationRouteField.tap()
        medicationRouteField.typeText("Test Route")
        
        medicationFrequencyField.tap()
        medicationFrequencyField.typeText("Test Frequency")
        
        medicationDurationField.tap()
        medicationDurationField.typeText("Test Duration")
        
        // Save medication
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(waitForElement(saveButton))
        saveButton.tap()
        
        // Wait for and verify medication details
        let ongoingMedsText = app.staticTexts["ONGOING MEDICATIONS"]
        let medNameText = app.staticTexts["Test Medication"]
        let medDoseText = app.staticTexts["Dose: Test Dose"]
        let medFreqText = app.staticTexts["Freq: Test Frequency"]
        let medDurationText = app.staticTexts["Duration: Test Duration"]
        
        XCTAssertTrue(waitForElement(ongoingMedsText))
        XCTAssertTrue(waitForElement(medNameText))
        XCTAssertTrue(waitForElement(medDoseText))
        XCTAssertTrue(waitForElement(medFreqText))
        XCTAssertTrue(waitForElement(medDurationText))
    }
    
    func addPatient(firstName: String, lastName: String) {
        let addButton = app.buttons["Add Patient"]
        XCTAssertTrue(waitForElement(addButton))
        addButton.tap()
        
        // Wait for and fill form fields
        let firstNameField = app.textFields["First Name"]
        let lastNameField = app.textFields["Last Name"]
        let heightField = app.textFields["Height (cm)"]
        let weightField = app.textFields["Weight (kg)"]
        
        XCTAssertTrue(waitForElement(firstNameField))
        XCTAssertTrue(waitForElement(lastNameField))
        XCTAssertTrue(waitForElement(heightField))
        XCTAssertTrue(waitForElement(weightField))
        
        firstNameField.tap()
        firstNameField.typeText(firstName)
        
        lastNameField.tap()
        lastNameField.typeText(lastName)
        
        heightField.tap()
        heightField.typeText("170")
        
        weightField.tap()
        weightField.typeText("70")
        
        // Save patient
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(waitForElement(saveButton))
        saveButton.tap()
    }
}
