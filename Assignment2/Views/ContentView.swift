//
//  ContentView.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/13/25.
//

import SwiftUI


/// A SwiftUI view for managing patient data, including a search bar, a patient list, and an add patient button.
/// - Manages patient state and supports searching and adding patients.
/// - Wrapped in a `NavigationView` with the title "Patients".
struct ContentView: View {
    @State private var patients: Patients = Patients()
    @State private var isAddingPatient = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(
                    text: $searchText
                )
                .padding(.horizontal)
                
                PatientListView(
                    patients: $patients,
                    searchText: $searchText
                )
                
                AddPatientButton(
                    isAddingPatient: $isAddingPatient,
                    patients: $patients
                )
            }
            .navigationTitle("Patients")
        }
    }
}

/// A SwiftUI view for showing a Button to add a new patient to `patients`
struct AddPatientButton: View {
    @Binding var isAddingPatient: Bool
    @Binding var patients: Patients
    
    var body: some View {
        Button(action: {
            isAddingPatient = true
        }) {
            Text("Add Patient")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .sheet(isPresented: $isAddingPatient) {
            AddPatientView(patients: $patients, isPresented: $isAddingPatient)
        }
    }
}

/// A SwiftUI view for showing the current Patient list
struct PatientListView: View {
    @Binding var patients: Patients
    @Binding var searchText: String
    
    var body: some View {
        List(filteredPatients, id: \.id) { patient in
            NavigationLink(destination: PatientDetailView(patient: patient)) {
                PatientRowView(patient: patient)
            }
        }
    }
    
    /// Returns the list of patients with two behaviors based on `searchText`
    /// If `searchText` is empty, returns all the patients
    /// Else returns the list of patients where `searchText` is in the last name of the patient
    private var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return patients.patientsList.sorted { $0.lastName.localizedCaseInsensitiveCompare($1.lastName) == .orderedAscending }
        } else {
            return patients.patientsList.filter {
                $0.lastName.localizedCaseInsensitiveCompare(searchText) == .orderedSame ||
                $0.lastName.lowercased().hasPrefix(searchText.lowercased())
            }
            .sorted { $0.lastName.localizedCaseInsensitiveCompare($1.lastName) == .orderedAscending }
        }
    }
}

/// A SwiftUI view for each row in the PatientListView
struct PatientRowView: View {
    var patient: Patient
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Profile picture for now is just first letters of first
            // and last names
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 40)  
                .overlay(
                    Text(String(patient.firstName.prefix(1).uppercased() + patient.lastName.prefix(1).uppercased()))
                        .font(.subheadline) 
                        .foregroundColor(.gray)
                )
            
            VStack(alignment: .leading, spacing: 2) {  
                Text(patient.fullName())
                    .font(.subheadline)  
                    .lineLimit(1)  
                
                HStack {
                    Text("Age: \(patient.age)")
                        .font(.footnote)  
                        .foregroundColor(.secondary)
                    
                    Text("MRN: \(patient.id.uuidString.prefix(6))")
                        .font(.footnote)  
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)  
    }
}

/// A SwiftUI view for the search bar
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Search", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
            )
            .padding(.horizontal, 10)
            .textFieldStyle(PlainTextFieldStyle())
    }
}

#Preview {
    ContentView()
}
