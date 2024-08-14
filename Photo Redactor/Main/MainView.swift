//
//  MainView.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

final class MainView: UITabBarController, UITabBarControllerDelegate {
    private enum Constants {
        static let homeIconImage = UIImage(systemName: "house")
        static let settingsIconImage = UIImage(systemName: "gear")
        
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
        self.delegate = self
        setupTabs()
        configureTabBar()
    }
    
    // MARK: - Delagate func
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.title = viewModel.getNavigationBarTitle(at: selectedIndex)
    }
}

// MARK: - Private methods
private extension MainView {
    func setupTabs() {
        let firstViewController = HomeBuilder.build()
        let secondViewController = SettingsBuilder.build()
        
        guard
            let firstViewController = firstViewController,
            let secondViewController = secondViewController
        else {
            return
        }
        
        firstViewController.tabBarItem = UITabBarItem(
            title: Constants.homeTitle,
            image: Constants.homeIconImage, tag: 0)
        secondViewController.tabBarItem = UITabBarItem(
            title: Constants.settingsTitle,
            image: Constants.settingsIconImage, tag: 1)
        
        viewControllers = [
            firstViewController,
            secondViewController
        ]
    }
    
    func configureTabBar() {
        tabBar.barStyle = .default
        tabBar.backgroundColor = .white
        tabBar.addSubview(topBorder)
    }
}
