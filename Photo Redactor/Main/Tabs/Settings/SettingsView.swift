//
//  SettingsView.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

final class SettingsView: UIViewController {
    
    // MARK: - Properties
    private var viewModel: SettingsViewModel
    
    // MARK: - Init
    init(viewModel: SettingsViewModel) {
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
        view.backgroundColor = .red
    }
}
