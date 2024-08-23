//
//  MainView.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

final class MainView: UITabBarController {
    private enum Constants {
        static let homeIconImage: UIImage = UIImage(systemName: "house")!
        static let settingsIconImage: UIImage = UIImage(systemName: "gear")!
        
        static let homeTitle = "Home"
        static let settingsTitle = "Settings"
        
        static let topBorderHeight: CGFloat = 0.5
    }
    
    // MARK: - Properties
    private var viewModel: MainViewModel
    
    // MARK: - Components
    private lazy var topBorder: UIView = {
        let lineView: UIView = .init(frame: CGRect(x: .zero, y: .zero, width: view.frame.width, height: Constants.topBorderHeight))
        lineView.backgroundColor = .gray
        return lineView
    }()
    
    // MARK: - Init
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        configureTabBar()
    }
}

// MARK: - Private methods
private extension MainView {
    func setupTabs() {
        guard
            let firstViewController = HomeBuilder.build(),
            let secondViewController = SettingsBuilder.build()
        else {
            return
        }
        
        let homeVC = createNavigationChain(
            title: Constants.homeTitle,
            image: Constants.homeIconImage,
            vc: firstViewController
        )
        let settingsVC = createNavigationChain(
            title: Constants.settingsTitle,
            image: Constants.settingsIconImage,
            vc: secondViewController
        )
        
        viewControllers = [
            homeVC,
            settingsVC
        ]
    }
    
    func configureTabBar() {
        tabBar.barStyle = .default
        tabBar.backgroundColor = .white
        tabBar.addSubview(topBorder)
    }
    
    func createNavigationChain(title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        return navigationController
    }
}
