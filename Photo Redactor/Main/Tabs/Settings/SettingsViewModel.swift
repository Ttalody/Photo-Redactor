//
//  SettingsViewModel.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import Foundation

final class SettingsViewModel {
    
    // MARK: - Properties
    private let model: SettingsModel
    
    // MARK: - Actions
    
    
    // MARK: - Init
    init(model: SettingsModel) {
        self.model = model
    }
    
    // MARK: - Public methods
    func getSettingsOptions() -> [SettingsModel.SettingsOptions] {
        model.settinsOptions
    }
    
    func getOption(at indexPath: IndexPath) -> SettingsModel.SettingsOptions {
        model.settinsOptions[indexPath.row]
    }
    
    func getAboutTitle() -> String {
        model.aboutTitle
    }
    
    func getAboutBody() -> String {
        model.aboutBody
    }
}
