//
//  PhoneNumberFormatter.swift
//  Hurd
//
//  Created by hunter downey on 3/16/23.
//

import Foundation

class PhoneNumberFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        if let str = obj as? String {
            let cleanedPhoneNumber = self.removeNonDigits(from: str)
            return self.format(cleanedPhoneNumber: cleanedPhoneNumber)
        }
        return nil
    }

    private func removeNonDigits(from string: String) -> String {
        return string.filter { $0.isWholeNumber }
    }

    private func format(cleanedPhoneNumber: String) -> String {
        var result = ""

        for (index, character) in cleanedPhoneNumber.enumerated() {
            switch index {
            case 0:
                result += "(\(character)"
            case 3:
                result += ") \(character)"
            case 6:
                result += "-\(character)"
            default:
                result += "\(character)"
            }
        }
        return result
    }
}
