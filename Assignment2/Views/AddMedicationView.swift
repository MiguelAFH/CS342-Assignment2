//
//  AddMedicationView.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/18/25.
//

import SwiftUI

/// A SwiftUI view that shows the form for adding a new medication to the patient
struct AddMedicationView: View {
    @Binding var patient: Patient
    @Binding var isPresented: Bool

    @State private var name = ""
    @State private var dose = ""
    @State private var route = ""
    @State private var frequency = ""
    @State private var duration = ""
    @State private var errorMessage: String?

    // Make sure that all the values are not empty strings
    private var isSaveEnabled: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !dose.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !route.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !frequency.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !duration.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("Medication Name")
                    .autocapitalization(.words)
                TextField("Dose", text: $dose)
                    .accessibilityIdentifier("Medication Dose")
                TextField("Route", text: $route)
                    .accessibilityIdentifier("Medication Route")
                TextField("Frequency", text: $frequency)
                    .accessibilityIdentifier("Medication Frequency")
                TextField("Duration", text: $duration)
                    .accessibilityIdentifier("Medication Duration")

                // Display error message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 4)
                }
            }
            .navigationTitle("Add Medication")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Don't add the medication if it already exists.
                        // We currently check only for name comparison
                        // between the list of ongoing medications and
                        // the medication to be added
                        if doesMedicationExist(name: name) {
                            errorMessage = "A medication with this name is already prescribed."
                        } else {
                            let newMedication = Medication(
                                name: name,
                                dose: dose,
                                route: route,
                                frequency: frequency,
                                duration: duration,
                                date: Date()
                            )
                            patient.prescribe(medication: newMedication)
                            isPresented = false
                        }
                    }
                    .disabled(!isSaveEnabled)
                }
            }
        }
    }
    
    private func doesMedicationExist(name: String) -> Bool {
        // Compare in the name of the medication is in any of
        // the ongoing medications
        patient.ongoingMedications.contains() { $0.name.caseInsensitiveCompare(name) == .orderedSame }
    }
}
