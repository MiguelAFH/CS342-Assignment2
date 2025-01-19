# Assignment 2 - SwiftUI Basics

## 1 - Patient List View

This is the main screen where you can see all the patients, add a new patient, and filter based on last name.
The medical record number is shortened to fit in screen and be visually appealing. The full id is shown in the patient details view.


### Files Implementing this view
* [ContentView.swift](https://github.com/MiguelAFH/CS342-Assignment2/blob/main/Assignment2/Views/ContentView.swift)

### Screenshots
<img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/PatientsList1.png" width="100"> <img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/PatientsList2.png" width="100">
<img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/SearchBar.png" width="100">


## 2 - New Patient Form

This is a sheet form that allows you to add a new patient. The form checks for empty strings and checks ranges for weight and height.

### Files Implementing this view
* [AddPatientView.swift](https://github.com/MiguelAFH/CS342-Assignment2/blob/main/Assignment2/Views/AddPatientView.swift)

### Screenshots
<img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/AddPatient1.png" width="100"> <img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/AddPatient2.png" width="100">

## 3 - Patient Detail View

This view shows all the information about a patient and shows an option to check their medications.

### Files Implementing this view
* [PatientDetailView.swift](https://github.com/MiguelAFH/CS342-Assignment2/blob/main/Assignment2/Views/PatientDetailView.swift)

### Screenshots
<img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/PatientDetails.png" width="100">

## 4 - Medications View

This view shows all the ongoning and past medications in two sections.

### Files Implementing this view
* [MedicationsView.swift](https://github.com/MiguelAFH/CS342-Assignment2/blob/main/Assignment2/Views/MedicationsView.swift)

### Screenshots
<img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/MedicationsList1.png" width="100"> <img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/MedicationsList2.png" width="100">

## 4.1 Exta - Added ability to mark medications as completed

### Files Implementing this view
* [MedicationsView.swift](https://github.com/MiguelAFH/CS342-Assignment2/blob/main/Assignment2/Views/MedicationsView.swift)

### Screenshots
<img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/MarkMedicationAsComplete1.png" width="100"> <img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/MarkMedicationAsComplete2.png" width="100"> <img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/MarkMedicationAsComplete3.png" width="100">

## 5 - New Medication Form

This form allows you to add a new medication while checking that there is no ongoing medication with the same name. If that is the case, it will not let you add the medication.

### Files Implementing this view
* [AddMedicationView](https://github.com/MiguelAFH/CS342-Assignment2/blob/main/Assignment2/Views/AddMedicationView.swift)

### Screenshots
<img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/AddMedication1.png" width="100"> <img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/AddMedication2.png" width="100"> <img src="https://github.com/MiguelAFH/CS342-Assignment2/blob/main/screenshots/AddMedication3.png" width="100">

## Unit tests

The unit tests aew for the models in this project: Patient, BloodType and Medication.

* [Assignment2Tests](https://github.com/MiguelAFH/CS342-Assignment2/tree/main/Assignment2Tests)

## UI Tests

The UI tests check the following aspects of the application:
* Adding a patient
* Navigation to a patient details view
* Filtering patients by last name
* Adding a patient and a medication

* [ContentViewUITests](https://github.com/MiguelAFH/CS342-Assignment2/blob/main/Assignment2UITests/ContentViewUITests.swift)

