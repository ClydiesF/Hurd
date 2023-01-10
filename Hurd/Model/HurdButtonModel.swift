//
//  HurdButtonModel.swift
//  Hurd
//
//  Created by clydies freeman on 12/27/22.
//

import Foundation

struct HurdButtonModel {
    let buttonText: String
    let buttonType: HurdButtonType
    let icon: HurdIcon?
    let appendingIcon: Bool?
}


enum HurdButtonType: String {
    case primary
    case secondary
    case tertiary
}

enum HurdIcon: String {
    case arrowRight
    case arrowLeft
    case sharePlane
    case group
    case itinarary
    case bookmark
}


extension HurdButtonModel {
    static let mockPrimaryButtonWithAppendingIcon = HurdButtonModel(buttonText: "Primary",
                                                                    buttonType: .primary,
                                                                    icon: .arrowRight,
                                                                    appendingIcon: true
                                                                )
    
    static let mockPrimaryButton = HurdButtonModel(buttonText: "Primary",
                                                   buttonType: .primary,
                                                   icon: nil,
                                                   appendingIcon: nil)
    
    static let mockPrimaryButtonWithPrependingIcon = HurdButtonModel(buttonText: "Primary",
                                                                     buttonType: .primary,
                                                                     icon: .arrowRight,
                                                                    appendingIcon: false)
    
    static let mockSecondaryButtonWithAppendingIcon = HurdButtonModel(buttonText: "Secondary",
                                                                      buttonType: .secondary,
                                                                      icon: .arrowRight,
                                                                    appendingIcon: true)
    
    static let mockSecondaryButton = HurdButtonModel(buttonText: "Secondary",
                                                     buttonType: .secondary,
                                                     icon: nil,
                                                     appendingIcon: nil)
    
    static let mockSecondaryButtonWithPrependingIcon = HurdButtonModel(buttonText: "Secondary",
                                                                       buttonType: .secondary,
                                                                       icon: .arrowRight,
                                                                    appendingIcon: false)
}
