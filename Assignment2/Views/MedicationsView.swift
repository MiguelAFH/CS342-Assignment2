//
//  PatientMedicationsView.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/14/25.
//

import SwiftUI


/// A SwiftUI view for the medications view containing
/// ongoing and past medications
struct MedicationsView: View {
    @Binding var patient: Patient
    @State private var isAddingMedication = false

    var body: some View {
        VStack {
            MedicationListView(patient: patient)

            Button(action: {
                isAddingMedication = true
            }) {
                Text("Add Medication")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .sheet(isPresented: $isAddingMedication) {
                AddMedicationView(patient: $patient, isPresented: $isAddingMedication)
            }
        }
    }
}

/// A SwiftUI view that shows the ongoing and past medications in two sections
struct MedicationListView: View {
    var patient: Patient
    var body: some View {
        List {
            if !patient.ongoingMedications.isEmpty {
                Section(header: Text("Ongoing Medications")) {
                    ForEach(patient.ongoingMedications, id: \.id) { medication in
                        MedicationRowView(medication: medication)
                    }
                }
            }
            if !patient.pastMedications.isEmpty {
                Section(header: Text("Past Medications")) {
                    ForEach(patient.pastMedications, id: \.id) { medication in
                        MedicationRowView(medication: medication)
                    }
                }
            }
        }        .navigationTitle("Medications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

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

/// A SwiftUI view that shows an entry of the MedicationList. The medication properties shown are:
/// - Name
/// - Dose
/// - Route
/// - Frequency
/// - Duration
struct MedicationRowView: View {
    var medication: Medication
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text(medication.name)
                    .font(.subheadline)
                    .lineLimit(1)
                
                HStack {
                    Text("Dose: \(medication.dose)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Text("Route: \(medication.route)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Freq: \(medication.frequency)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Text("Duration: \(medication.duration)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let patient = Patient(
        firstName: "John",
        lastName: "Doe",
        birthDate: Date(),
        height: 180,
        weight: 75,
        bloodType: BloodType.aNegative,
        medications: Medications(medicationList: [
            Medication(name: "Med1", dose: "50mg", route: "by mouth", frequency: "once daily", duration: "10 days", date: Date()),
            Medication(name: "Med2", dose: "50mg", route: "by mouth", frequency: "once daily", duration: "10 days", date: Date(), completed: true)
        ])
    )
    MedicationsView(patient: .constant(patient))
}
