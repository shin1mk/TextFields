//
//  Constants.swift
//  TextFields
//
//  Created by SHIN MIKHAIL on 20.06.2023.
//

import UIKit

extension MainController {
    enum Constants {
        static let topOffset = 95
        static let horizontalInset = 16
        enum Label {
            static let topOffset = 30
        }
        enum Input {
            static let topOffset = 11
            static let height = 30
        }
    }
    
    enum Colors {
        static let black = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        static let blue = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        static let gray = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
        static let lightGray = UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1.0)
        static let inputGray = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)

    }
}
