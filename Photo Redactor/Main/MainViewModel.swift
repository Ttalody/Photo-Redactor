//
//  MainViewModel.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import Foundation

final class MainViewModel {
    func getNavigationBarTitle(at index: Int) -> String {
        switch index {
        case 1:
            "Settings"
        default:
            ""
        }
    }
}
