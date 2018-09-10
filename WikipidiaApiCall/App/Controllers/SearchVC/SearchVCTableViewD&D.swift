//
//  SearchVCTableViewD&D.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit

// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBarW.resignFirstResponder()
        if UserDefaults.standard.bool(forKey: UserDefaultString.networkRechability)  {
            selectedIndex = indexPath.row
            performSegue(withIdentifier: SegueID.SearchVCToDetailWebVC, sender: nil)
        }else {
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Table View DataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !UserDefaults.standard.bool(forKey: UserDefaultString.networkRechability) {
            return (coreDataObj.getSearchDataCount() + 1)
        }
        if (searchBarW.text?.count)! > 0 {
            return searchVM.getTotallNumOfCells()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !UserDefaults.standard.bool(forKey: UserDefaultString.networkRechability)  {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.noNetworkCell, for: indexPath) as! NoNetworkTVCell
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.seacrhTableViewCell, for: indexPath) as! SeacrchVCTableViewCell
                if indexPath.row < coreDataObj.getSearchDataCount() ||  indexPath.row == coreDataObj.getSearchDataCount(){
                    cell.setdataForCoreData(coreModel: coreDataObj, index: (indexPath.row - 1) )
                }
                return cell
            }
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.seacrhTableViewCell, for: indexPath) as! SeacrchVCTableViewCell
            if indexPath.row < searchVM.getTotallNumOfCells() {
                cell.setData(searchVM: searchVM, index: indexPath.row)
            }
            return cell
        }
    }
    
}
