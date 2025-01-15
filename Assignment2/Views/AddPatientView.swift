//
//  AddPatientView.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/14/25.
//

import SwiftUI


/// A SwiftUI view that shows the form to add a new Patient
struct AddPatientView: View {
    @Binding var patients: Patients
    @Binding var isPresented: Bool
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date()
    @State private var heightText = ""
    @State private var weightText = ""
    @State private var selectedBloodType: BloodType? = nil
    
    
    // Make sure that the height and weight are between acceptable bounds
    let heightRange: ClosedRange<Double> = 1...300
    let weightRange: ClosedRange<Double> = 1...1000
    
    
    private var isHeightValid: Bool {
        if let height = Double(heightText), heightRange.contains(height) {
            return true
        }
        return false
    }
    
    private var isWeightValid: Bool {
        if let weight = Double(weightText), weightRange.contains(weight) {
            return true
        }
        return false
    }
    
    // Only enable saving if all values are valid
    private var isSaveEnabled: Bool {
        !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        isHeightValid &&
        isWeightValid
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("First Name", text: $firstName)
                    .accessibilityIdentifier("First Name")
                    .autocapitalization(.words)
                TextField("Last Name", text: $lastName)
                    .accessibilityIdentifier("Last Name")
                    .autocapitalization(.words)
                DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                    .accessibilityIdentifier("Birth Date")
                
                TextField("Height (cm)", text: $heightText)
                    .accessibilityIdentifier("Height (cm)")
                    .keyboardType(.decimalPad)
                    .foregroundColor(isHeightValid ? .primary : .red)
                
                TextField("Weight (kg)", text: $weightText)
                    .accessibilityIdentifier("Weight (kg)")
                    .keyboardType(.decimalPad)
                    .foregroundColor(isWeightValid ? .primary : .red)
                // Set BloodType as optional by setting initially to none
                Picker("Blood Type", selection: $selectedBloodType) {
                    Text("None").tag(BloodType?.none)
                    ForEach(BloodType.allCases, id: \.self) { bloodType in
                        Text(bloodType.description).tag(bloodType as BloodType?)
                    }
                }
                .accessibilityIdentifier("Blood Type")
            }
            .navigationTitle("Add Patient")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard let height = Double(heightText), let weight = Double(weightText) else { return }
                        
                        let newPatient = Patient(
                            firstName: firstName,
                            lastName: lastName,
                            birthDate: birthDate,
                            height: height,
                            weight: weight,
                            bloodType: selectedBloodType
                        )
                        patients.patientsList.append(newPatient)
                        isPresented = false
                    }
                    .disabled(!isSaveEnabled)
                }
            }
        }
    }
}

#Preview {
    AddPatientView(
        patients: .constant(Patients()),
        isPresented: .constant(true)
    )
}
