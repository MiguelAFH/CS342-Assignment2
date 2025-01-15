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
        
        // Fill out the form
        let firstNameField = app.textFields["First Name"]
        firstNameField.tap()
        firstNameField.typeText("Test")
        
        let lastNameField = app.textFields["Last Name"]
        lastNameField.tap()
        lastNameField.typeText("Patient")
        
        let heightField = app.textFields["Height (cm)"]
        heightField.tap()
        heightField.typeText("170")
        
        let weightField = app.textFields["Weight (kg)"]
        weightField.tap()
        weightField.typeText("70")
        
        // Save patient
        app.buttons["Save"].tap()
        
        // Verify patient appears in list
        XCTAssertTrue(app.staticTexts["Patient, Test"].exists)
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
    
    func addPatient(firstName: String, lastName: String) {
        app.buttons["Add Patient"].tap()
        
        // Fill out the form
        let firstNameField = app.textFields["First Name"]
        firstNameField.tap()
//        firstNameField.press(forDuration: 1.1)
        firstNameField.typeText(firstName)
//        app.keyboards.buttons["Return"].tap()
        
        let lastNameField = app.textFields["Last Name"]
        lastNameField.tap()
//        lastNameField.press(forDuration: 1.1)
        lastNameField.typeText(lastName)
//        app.keyboards.buttons["Return"].tap()
        
        let heightField = app.textFields["Height (cm)"]
        heightField.tap()
//        heightField.press(forDuration: 1.1)
        heightField.typeText("170")
//        app.keyboards.buttons["Return"].tap()
        
        let weightField = app.textFields["Weight (kg)"]
        weightField.tap()
//        weightField.press(forDuration: 1.1)
        weightField.typeText("70")
//        app.keyboards.buttons["Return"].tap()
        
        // Save patient
        app.buttons["Save"].tap()
    }
}
