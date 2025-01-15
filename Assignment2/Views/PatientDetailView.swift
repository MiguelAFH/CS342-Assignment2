//
//  PatientDetailView.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/13/25.
//

import SwiftUI


/// A SwiftUI view that shows the patient details. The details contain:
///  - Profile picture (First letter of first and last name for now)
///  - Full name
///  - Birth date, height, weight, blood type and medical record number
///  - Button to see all medications
struct PatientDetailView: View {
    @State var patient: Patient
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    ProfilePictureView(patient: patient)
                    
                    Text("\(patient.firstName) \(patient.lastName)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    PatientInformationView(patient: patient)
                    
                    // Link to medications
                    NavigationLink(destination: MedicationsView(patient: $patient)) {
                        HStack {
                            Text("Medications")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemGray6))
                        )
                    }
                    .padding()
                }
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Patient Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// A SwiftUI view that shows the relevant information from a Patient
struct PatientInformationView: View {
    var patient: Patient
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            DetailRow(label: "Birth Date", value: formattedDate(from: patient.birthDate))
            DetailRow(label: "Height", value: "\(patient.height.description) cm")
            DetailRow(label: "Weight", value: "\(patient.weight.description) kg")
            DetailRow(label: "Blood Type", value: patient.bloodType?.description ?? "UNKNOWN")
            DetailRow(label: "MRN:", value: patient.id.uuidString)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray6))
        )
        .padding(.horizontal)
    }
    
    private func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

/// A SwiftUI view that shows the profile picture of a Patient
struct ProfilePictureView: View {
    var patient: Patient
    var body: some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 120, height: 120)
            .overlay(
                Text(String(patient.firstName.prefix(1).uppercased() + patient.lastName.prefix(1).uppercased()))
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            )
            .padding(.top, 20)
    }
}

/// A SwiftUI view for each entry in the PatientInformationView
struct DetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
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
    PatientDetailView(patient: patient)
}
