//
//  Extension.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 11/03/2022.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
