//
//  SettingsModel.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import Foundation

final class SettingsModel {
    let aboutTitle = "Made by"
    let aboutBody = "Artur Akulich"
    
    let settinsOptions = SettingsOptions.allCases
    
    enum SettingsOptions: String, CaseIterable {
        case about = "About"
    }
}
