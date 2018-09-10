//
//  DetailWebViewController.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit

class DetailWebViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// WebView
    @IBOutlet weak var detailWebView: UIWebView!
    
    var webUrl = ""             // Url to be opened in Web View
    var pageTittle = ""         // Navigatiob bar Tittle String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: webUrl)
        let requestObj = URLRequest(url: url!)
        detailWebView.loadRequest(requestObj)
        self.title = pageTittle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
