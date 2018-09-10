//
//  SeacrchVCTableViewCell.swift
//  WikipidiaApiCall
//
//  Created by Rajan Singh on 09/09/18.
//  Copyright © 2018 Rajan Singh. All rights reserved.
//

import UIKit
import Kingfisher

class SeacrchVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchRestittleLabel: UILabel!
    @IBOutlet weak var searchResDisLabel: UILabel!
    @IBOutlet weak var searchResImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    /// Set Data For Cell
    ///
    /// - Parameters:
    ///   - searchVM: ServiceViewModel Object To Set Data
    ///   - index: index of the particular cell
    func setData(searchVM: SearchVCViewModel, index: Int) {
        searchRestittleLabel.text = searchVM.getTittle(index: index)
        searchResDisLabel.text = searchVM.getDiscription(index: index)
        if searchVM.getImageUrl(index: index).count > 0{
            let url = URL(string: searchVM.getImageUrl(index: index))
            searchResImage.kf.setImage(with: url,
                                     placeholder: #imageLiteral(resourceName: "userDefault"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
        }else {
            searchResImage.image = #imageLiteral(resourceName: "userDefault")
        }
    }
    
    /// Core Data Model
    ///
    /// - Parameters:
    ///   - coreModel: core Data Model
    ///   - index: index of the Cell
    func setdataForCoreData(coreModel: CoreDataModel, index: Int) {
        searchRestittleLabel.text = coreModel.getTittle(index: index)
        searchResDisLabel.text = coreModel.getDiscription(index: index)
        if coreModel.getimageUrl(index: index).count > 0{
            let url = URL(string: coreModel.getimageUrl(index: index))
            searchResImage.kf.setImage(with: url,
                                       placeholder: #imageLiteral(resourceName: "userDefault"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
        }else {
            searchResImage.image = #imageLiteral(resourceName: "userDefault")
        }
    }

}
