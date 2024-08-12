//
//  HomeBuilder.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

final class HomeBuilder {
    static func build() -> UIViewController? {
        let homeViewModel: HomeViewModel = .init()
        let homeModel: HomeModel = .init()
        let view: HomeViewController = .init(viewModel: homeViewModel)
        return view
    }
}
