//
//  SearchViewController.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    
    /// Search Bar
    @IBOutlet weak var searchBarW: UISearchBar!
    
    /// TableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var searchVM = SearchVCViewModel()
    var selectedIndex: Int!
    var coreDataObj = CoreDataModel.sharedInstance()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = CGFloat(SearchVC.tableViewEstimatedHeight)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SegueID.SearchVCToDetailWebVC) {
            if let dstVC = segue.destination as? DetailWebViewController {
                dstVC.webUrl = searchVM.getmainUrl(index: selectedIndex)
                dstVC.pageTittle = searchVM.getTittle(index: selectedIndex)
            }
        }
    }
    
    
    /// Search Api Call To View Model
    ///
    /// - Parameter searchString: string to be searched in Wikipedia
    func searchInWiki(_ searchString: String) {
        if searchString.count > 0 {
            if !UserDefaults.standard.bool(forKey: UserDefaultString.networkRechability) {
                coreDataObj.fetchFromCoreData()
                coreDataObj.searchDataForSearchString(searchtext: searchString, complitionHandler: { (boolValue) in
                    self.tableView.reloadData()
                })
            }else {
                searchVM.searchTextInWikipidiaApiCall(searchText: searchString) { (boolValue) in
                    if boolValue {
                        self.coreDataObj.saveData(searchVCViewM: self.searchVM)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    

}


// MARK: - Search bar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchString = ""
        if searchBar.text != nil {
            if (searchBar.text?.contains(" "))! {
                let searchableString = searchBar.text!
                let text = searchableString.components(separatedBy: " ")
                searchString = text[0]
                if text.count > 1 {
                    for index in 1...(text.count - 1) {
                        searchString.append("+" + text[index])
                    }
                }
            }else if (searchBar.text?.count)! > 0 {
                searchString = searchBar.text!
            }else if (searchBar.text?.count)! == 0{
                tableView.reloadData()
            }
        }
       searchInWiki(searchString)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text?.count)! > 0 {
            searchInWiki(searchBar.text!)
        }
        searchBar.resignFirstResponder()
    }
    
    
    
}




