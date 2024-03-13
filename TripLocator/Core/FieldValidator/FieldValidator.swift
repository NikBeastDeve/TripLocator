import Foundation
import UIKit

typealias ValidateResult = (isValidated: Bool, error: Error?)

enum ValidatorFieldType {
    case empty
    case minCharacters(numOfChars: Int)
    case maxCharacters(numOfChars: Int)
    case combined(validators: [ValidatorFieldType])
}

class FieldValidator {
    enum Error: LocalizedError {
        case custom(String)
        case invalid
        
        var errorDescription: String? {
            switch self {
            case .custom(let reason): return reason
            case .invalid: return "Invalid characters"
            }
        }
    }
    
    static func validate(text: String, as fieldType: ValidatorFieldType) -> ValidateResult {
        switch fieldType {
        case .empty:
            return validateEmpty(text: text)
        case .minCharacters(numOfChars: let numOfChars):
            return validateNumChars(text: text, numOfChars: numOfChars)
        case .maxCharacters(numOfChars: let numOfChars):
            return validateMaxNumChars(text: text, numOfChars: numOfChars)
        case .combined(validators: let validators):
            return validateCombined(text: text, validators: validators)
        }
    }
    
    private static func validateNumChars(text: String, numOfChars: Int) -> ValidateResult {
        guard text.count >= numOfChars else {
            return (false, Error.custom("PleaseProvide \(numOfChars) Min"))
        }
        return (true, nil)
    }
    
    private static func validateMaxNumChars(text: String, numOfChars: Int) -> ValidateResult {
        guard text.count <= numOfChars else {
            return (false, Error.custom("PleaseProvide \(numOfChars) Max"))
        }
        return (true, nil)
    }
    
    private static func validateEmpty(text: String) -> ValidateResult {
        guard !text.isEmpty else {
            return (false, Error.custom("Mandatory Field"))
        }
        return (true, nil)
    }
    
    private static func validateCombined(text: String, validators: [ValidatorFieldType]) -> ValidateResult {
        for validator in validators {
            let result = validate(text: text, as: validator)
            if !result.isValidated {
                return result
            }
        }
        return (true, nil)
    }
    
}
