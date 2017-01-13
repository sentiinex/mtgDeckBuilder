//
//  CDVC+TableViewData.swift
//  MTGPrices
//
//  Created by Gabriele Pregadio on 1/10/17.
//  Copyright © 2017 Gabriele Pregadio. All rights reserved.
//

import UIKit

extension CardDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableViewData[indexPath.section] == "" || tableViewData[indexPath.section] == "/" {
            return 0
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.names.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Sections.names[indexPath.section] == "Cost" {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.costFieldCell, for: indexPath) as! CostFieldTableViewCell
            cell.configureCost(from: shouldUseResult ? cardResult!.manaCost?.createManaCostImages() : card!.manaCost?.createManaCostImages())
            cell.costLabel.text = "Cost"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.fieldCell, for: indexPath) as! FieldTableViewCell
            cell.fieldTitle.text = Sections.names[indexPath.section]
            cell.fieldData.text = tableViewData[indexPath.section].replacingOccurrences(of: "−", with: "-")
            if Sections.names[indexPath.section] == "Flavor" {
                cell.fieldData.font = UIFont(name: "MPlantin-Italic", size: 17.0)
            } else {
                cell.fieldData.font = UIFont(name: "MPlantin", size: 17.0)
            }
            return cell
        }
    }
    
    
    // MARK: - Supporting Functionality
    
    struct Cell {
        static let fieldCell = "Field Cell"
        static let costFieldCell = "Cost Field Cell"
    }
    
    struct Sections {
        static let names = ["Name", "Cost", "Type", "P/T", "Set", "Text", "Flavor"]
    }
    
}