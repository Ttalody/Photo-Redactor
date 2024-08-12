//
//  MainBuilder.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

final class MainBuilder {
    static func build() -> UIViewController {
        let viewModel: MainViewModel = .init()
        let view: MainView = .init(viewModel: viewModel)
        return view
    }
}
