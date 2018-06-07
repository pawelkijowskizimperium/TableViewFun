//
//  ViewController.swift
//  TableViewFun
//
//  Created by Pawel Kijowski on 6/7/18.
//  Copyright © 2018 Pawel Kijowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let visibleCells: [CellID] = [.deviceID, .licenseAgreement, .privacyPolicy, .version, .build]
    
    enum CellID: Int {
        case licenseAgreement = 0
        case privacyPolicy
        case legalInfo
        case version
        case build
        case deviceID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // UITableViewDataSource
    func numberOfRows(visibleCells: [CellID]) -> Int {
        return visibleCells.count
    }
    
    func cellEnum(fromIndexPath indexPath: IndexPath, visibleCells: [CellID]) -> CellID? {
        let sortedVisibleCells = visibleCells.sorted { (lhs, rhs) -> Bool in
            return lhs.rawValue < rhs.rawValue
        }
        var cellID: CellID? = nil
        if (indexPath.row < sortedVisibleCells.count) {
            cellID = sortedVisibleCells[indexPath.row]
        }
        return cellID
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(visibleCells: visibleCells)
    }
    
    let cellReuseId = "AboutViewCellReuseID"
    func cell(cellForRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        var cell: UITableViewCell!
        if let c = tableView.dequeueReusableCell(withIdentifier: cellReuseId) {
            cell = c
        } else {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellReuseId)
        }
        let currentFontPointSize: CGFloat = cell.textLabel?.font.pointSize != nil ? cell.textLabel!.font.pointSize : 17.0
        cell.textLabel?.font = UIFont.systemFont(ofSize: currentFontPointSize)
        cell.textLabel?.textColor = UIColor(red: 31.0/255.0, green: 49.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        let image = UIImage(named: "icArrowRightNormal")
        let accessoryView = UIImageView(image: image)
        guard let row = cellEnum(fromIndexPath: indexPath, visibleCells: visibleCells) else { return cell }
        switch row {
        case .licenseAgreement:
            cell.textLabel?.text = "License Agreement"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
            cell.accessoryView = accessoryView
        case .privacyPolicy:
            cell.textLabel?.text = "Privacy Policy"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
            cell.accessoryView = accessoryView
        case .legalInfo:
            cell.textLabel?.text = "Legal Information"
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .disclosureIndicator
            cell.accessoryView = accessoryView
        case .version:
            cell.textLabel?.text = "Version"
            cell.detailTextLabel?.text = "DEV.DEV (MDM)"
        case .build:
            cell.textLabel?.text = "Build"
            cell.detailTextLabel?.text = "1048"
        case .deviceID:
            cell.textLabel?.text = "Device ID"
            cell.detailTextLabel?.text = "DEADBEEF"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cell(cellForRowAt: indexPath, in: tableView)
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tappedCell = cellEnum(fromIndexPath: indexPath, visibleCells: visibleCells) else { return }
        switch tappedCell {
        case .licenseAgreement:
            print("License Agreement")
        case .privacyPolicy:
            print("Privacy Policy")
        case .legalInfo:
            print("Legal Information")
        case .version:
            print("Version")
        case .build:
            print("Build")
        case .deviceID:
            print("Device ID")
        }
    }
}

