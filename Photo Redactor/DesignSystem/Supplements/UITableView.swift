//
//  UITableView.swift
//  Photo Redactor
//
//  Created by Артур on 13.08.2024.
//

import UIKit

extension UITableView {
    func registerCells(_ cells: [UITableViewCell.Type]) {
        cells.forEach { register($0, forCellReuseIdentifier: $0.reuseID) }
    }
}
