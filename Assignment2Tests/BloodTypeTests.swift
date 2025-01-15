//
//  BloodTypeTests.swift
//  Assignment2Tests
//
//  Created by Miguel Fuentes on 1/13/25.
//

import Testing
@testable import Assignment2

struct BloodTypeTests {
    
    // Verifies that the description of 'A+' is returned correctly.
    @Test func aPositive() async throws {
        #expect(BloodType.aPositive.description == "A+")
    }
    
    // Verifies that the description of 'A-' is returned correctly.
    @Test func aNegative() async throws {
        #expect(BloodType.aNegative.description == "A-")
    }
    
    // Verifies that the description of 'B+' is returned correctly.
    @Test func bPositive() async throws {
        #expect(BloodType.bPositive.description == "B+")
    }
    
    // Verifies that the description of 'B-' is returned correctly.
    @Test func bNegative() async throws {
        #expect(BloodType.bNegative.description == "B-")
    }
    
    // Verifies that the description of 'O+' is returned correctly.
    @Test func oPositive() async throws {
        #expect(BloodType.oPositive.description == "O+")
    }
    
    // Verifies that the description of 'O-' is returned correctly.
    @Test func oNegative() async throws {
        #expect(BloodType.oNegative.description == "O-")
    }
    
    // Verifies that the description of 'AB+' is returned correctly.
    @Test func abPositive() async throws {
        #expect(BloodType.abPositive.description == "AB+")
    }
    
    // Verifies that the description of 'AB-' is returned correctly.
    @Test func abNegative() async throws {
        #expect(BloodType.abNegative.description == "AB-")
    }

}
