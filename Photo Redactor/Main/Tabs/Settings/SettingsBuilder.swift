//
//  SettingsBuilder.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

final class SettingsBuilder {
    static func build() -> UIViewController? {
        let settingsViewModel: SettingsViewModel = .init()
        let settingsModel: SettingsModel = .init()
        let view: SettingsView = .init(viewModel: settingsViewModel)
        return view
    }
}
