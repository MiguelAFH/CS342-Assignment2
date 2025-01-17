import XCTest
@testable import Assignment2

final class ContentViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    // MARK: - ContentView Tests
    
    func testContentViewInitialState() throws {
        // Verify navigation title
        XCTAssertTrue(app.navigationBars["Patients"].exists)
        
        // Verify search bar exists
        let searchField = app.textFields["Search"]
        XCTAssertTrue(searchField.exists)
        
        // Verify add patient button exists
        let addButton = app.buttons["Add Patient"]
        XCTAssertTrue(addButton.exists)
    }
    
    // MARK: - Patient Search Bar Tests
    
    func testPatientListFiltering() throws {
        addPatient(firstName: "TestFirst1", lastName: "TestLast1")
        addPatient(firstName: "TestFirst2", lastName: "TestLast2")
        
        // Test filtering
        let searchField = app.textFields["Search"]
        searchField.tap()
        searchField.typeText("TestLast1")
        
        // Verify only TestLast1 is visible
        XCTAssertTrue(app.staticTexts["TestLast1, TestFirst1"].exists)
        XCTAssertFalse(app.staticTexts["TestLast2, TestFirst2"].exists)
    }
    
    // MARK: - Add Patient Tests
    
    func testAddPatientFlow() throws {
        // Tap add patient button
        app.buttons["Add Patient"].tap()
        
        // Verify add patient sheet is presented
        XCTAssertTrue(app.textFields["First Name"].exists)
        XCTAssertTrue(app.textFields["Last Name"].exists)
        XCTAssertTrue(app.textFields["Height (cm)"].exists)
        XCTAssertTrue(app.textFields["Weight (kg)"].exists)
        XCTAssertTrue(app.staticTexts["Birth Date"].exists)
        XCTAssertTrue(app.staticTexts["Blood Type"].exists)
        
        // Fill First Name
        let firstNameField = app.textFields["First Name"]
        firstNameField.tap()
        firstNameField.typeText("Test")
        
        // Fill Last Name
        let lastNameField = app.textFields["Last Name"]
        lastNameField.tap()
        lastNameField.typeText("Patient")
        
        // Fill Birth Date
        let datePicker = app.datePickers["Birth Date"]
        datePicker.tap()
        app.staticTexts["20"].tap()
        app.staticTexts["January 2025"].tap()
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "May")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "2002")
        app.buttons["PopoverDismissRegion"].tap()
        
        // Fill Height
        let heightField = app.textFields["Height (cm)"]
        heightField.tap()
        heightField.typeText("170")
        
        // Fill Weight
        let weightField = app.textFields["Weight (kg)"]
        weightField.tap()
        weightField.typeText("70")
        
        // Save patient
        app.buttons["Save"].tap()
        
        // Verify patient appears in list
        XCTAssertTrue(app.staticTexts["Patient, Test"].exists)
        XCTAssertTrue(app.staticTexts["Age: 22"].exists)
    }
    
    // MARK: - Navigation Tests
    
    func testPatientDetailNavigation() throws {
        // Add a test patient
        addPatient(firstName: "TestFirst", lastName: "TestLast")
        
        // Tap on patient row
        app.staticTexts["TestLast, TestFirst"].tap()
        
        // Verify navigation to detail view
        XCTAssertTrue(app.navigationBars["Patient Details"].exists)
    }
    
    // MARK: - Medication Tests
    
    func testAddMedication() throws {
        addPatient(firstName: "TestFirst", lastName: "TestLast")
        
        // Navigate to the TestFirst TestLast medications view
        app.staticTexts["TestLast, TestFirst"].tap()
        app.staticTexts["Medications"].tap()
        
        // Open the Add Medication Form
        app.buttons["Add Medication"].tap()
        
        // Type Medication Name
        let medicationNameField = app.textFields["Medication Name"]
        medicationNameField.tap()
        medicationNameField.typeText("Test Medication")
        
        // Type Medication Dose
        let medicationDoseField = app.textFields["Medication Dose"]
        medicationDoseField.tap()
        medicationDoseField.typeText("Test Dose")
        
        // Type Medication Route
        let medicationRouteField = app.textFields["Medication Route"]
        medicationRouteField.tap()
        medicationRouteField.typeText("Test Route")
        
        // Type Medication Frequency
        let medicationFrequencyField = app.textFields["Medication Frequency"]
        medicationFrequencyField.tap()
        medicationFrequencyField.typeText("Test Frequency")
        
        // Type Medication Duration
        let medicationDurationField = app.textFields["Medication Duration"]
        medicationDurationField.tap()
        medicationDurationField.typeText("Test Duration")
        
        // Save Medication
        app.buttons["Save"].tap()
        
        // Check that the medication is on screen
        XCTAssertTrue(app.staticTexts["ONGOING MEDICATIONS"].exists)
        XCTAssertTrue(app.staticTexts["Test Medication"].exists)
        XCTAssertTrue(app.staticTexts["Dose: Test Dose"].exists)
        XCTAssertTrue(app.staticTexts["Freq: Test Frequency"].exists)
        XCTAssertTrue(app.staticTexts["Duration: Test Duration"].exists)
    }
    
    func addPatient(firstName: String, lastName: String) {
        app.buttons["Add Patient"].tap()
        
        // Fill First Name
        let firstNameField = app.textFields["First Name"]
        firstNameField.tap()
        firstNameField.typeText(firstName)
        
        // Fill Last Name
        let lastNameField = app.textFields["Last Name"]
        lastNameField.tap()
        lastNameField.typeText(lastName)
        
        // Fill Height
        let heightField = app.textFields["Height (cm)"]
        heightField.tap()
        heightField.typeText("170")
        
        // Fill Weight
        let weightField = app.textFields["Weight (kg)"]
        weightField.tap()
        weightField.typeText("70")
        
        // Save patient
        app.buttons["Save"].tap()
    }
}
