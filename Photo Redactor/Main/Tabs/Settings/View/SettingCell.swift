//
//  SettingCell.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
//

import UIKit

// MARK: - Cell Attributes
extension SettingCell {
    struct Attribute {
        let title: String?
        
        init(title: String? = nil) {
            self.title = title
        }
    }
}

// MARK: - Prepare Cell
extension SettingCell {
    static func prepareCell(tableView: UITableView, indexPath: IndexPath, attribute: Attribute?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.reuseID,
            for: indexPath
        ) as? Self,
              let attribute else {
            return UITableViewCell()
        }
        cell.configure(with: attribute)
        return cell
    }
}

// MARK: - SettingCell
final class SettingCell: UITableViewCell {
    // MARK: - Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = .zero
        label.textColor = .black
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configure(with attributes: Attribute) {
        titleLabel.text = attributes.title
    }
}

// MARK: - Private methods
private extension SettingCell {
    // MARK: - Setup
    func setupView() {
        
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Grid.Spacing.m)
        let bottom = titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Grid.Spacing.m)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Grid.Spacing.m)
        let trailing = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Grid.Spacing.m)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
}
