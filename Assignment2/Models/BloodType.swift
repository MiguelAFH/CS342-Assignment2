//
//  BloodType.swift
//  Assignment2
//
//  Created by Miguel Fuentes on 1/13/25.
//

import Foundation


/**
    Represents the blood types, including both the Rh factor (positive or negative)
    and the ABO blood group system.

    - `aPositive`: "A+" blood type
    - `aNegative`: "A-" blood type
    - `bPositive`: "B+" blood type
    - `bNegative`: "B-" blood type
    - `oPositive`: "O+" blood type
    - `oNegative`: "O-" blood type
    - `abPositive`: "AB+" blood type
    - `abNegative`: "AB-" blood type
 */
enum BloodType: CustomStringConvertible, CaseIterable {
    case aPositive
    case aNegative
    case bPositive
    case bNegative
    case oPositive
    case oNegative
    case abPositive
    case abNegative
    
    var description: String {
        switch self {
        case .aPositive:
            return "A+"
        case .aNegative:
            return "A-"
        case .bPositive:
            return "B+"
        case .bNegative:
            return "B-"
        case .oPositive:
            return "O+"
        case .oNegative:
            return "O-"
        case .abPositive:
            return "AB+"
        case .abNegative:
            return "AB-"
        }
    }
}
