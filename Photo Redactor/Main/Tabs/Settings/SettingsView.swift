//
//  SettingsView.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

final class SettingsView: UIViewController {
    enum Constants {
        static let alertActionTitle = "Close"
    }
    
    // MARK: - Properties
    private var viewModel: SettingsViewModel
    
    // MARK: - Components
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCells([SettingCell.self])
        
        return tableView
    }()
    
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
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}

// MARK: - TableView configuration
extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getSettingsOptions().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = viewModel.getOption(at: indexPath)
        switch option {
        case .about:
            return SettingCell.prepareCell(
                tableView: tableView,
                indexPath: indexPath,
                attribute: .init(
                    title: option.rawValue
                )
            )
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showAlert(title: viewModel.getAboutTitle(), message: viewModel.getAboutBody())
    }
}

// MARK: - Private methods
private extension SettingsView {
    // MARK: - Setup
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(settingsTableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        let top = settingsTableView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottom = settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leading = settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .secondarySystemBackground
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 32, weight: .bold)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    // MARK: - Alert
    func showAlert(title: String ,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTitle, style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
