//
//  PatientMedicationsView.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/14/25.
//

import SwiftUI

struct MedicationsView: View {
    @Binding var patient: Patient
    @State private var isAddingMedication = false

    var body: some View {
        VStack {
            MedicationListView(patient: $patient)

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

struct MedicationListView: View {
    @Binding var patient: Patient
    
    var body: some View {
        List {
            if !patient.ongoingMedications.isEmpty {
                Section(header: Text("Ongoing Medications")) {
                    ForEach(patient.medications.enumerated().filter { !$0.element.completed }
                           .map { (index: $0.offset, medication: $0.element) },
                           id: \.medication.id) { indexedMedication in
                        MedicationRowView(medication: indexedMedication.medication)
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    markMedicationAsCompleted(at: indexedMedication.index)
                                } label: {
                                    Label("Complete", systemImage: "checkmark.circle.fill")
                                }
                                .tint(.green)
                            }
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
        }
        .navigationTitle("Medications")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func markMedicationAsCompleted(at index: Int) {
        patient.medications.medicationList[index].complete()
    }
}

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
            
            if medication.completed {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
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
