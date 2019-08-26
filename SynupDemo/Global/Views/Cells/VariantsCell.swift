//
//  VariantsCell.swift
//  SynupDemo
//
//  Created by Pankaj Verma on 24/08/19.
//  Copyright © 2019 Pankaj Verma. All rights reserved.
//

import UIKit

protocol VariantsCellDelegate: class{
    func radioButtonSelected(_ selected:Bool, forSection indexPath:IndexPath?)
}

class VariantsCell: UITableViewCell, NibLoadableView, ReuseIdentifier{
    
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOutOfStock: UILabel!

    
    var indexPath:IndexPath?
    weak var delegate:VariantsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        radioButton.setBackgroundImage(#imageLiteral(resourceName: "radioInactive"), for: .normal)
        radioButton.isSelected = false

    }

    func initialise()
    {
        lblName.numberOfLines = 0
    }
    
    func setModel(viewModel:HomeModel.HomeViewModel.DisplayedVarient?, indexPath:IndexPath, delegate:VariantsCellDelegate?)
    {
        self.indexPath = indexPath
        self.delegate = delegate
        
        
        self.lblName.text = viewModel?.name
        if let price = viewModel?.price {
            self.lblPrice.text = "₹ " + price.stringValue + "/-"
        }
        radioButton.isSelected = viewModel?.selected ?? false
        setIconForRadioBtnState(radioButton.isSelected)
        if viewModel?.isVeg ?? true {
            lblName.textColor = .green
        }
        else {
            lblName.textColor = .red
        }
        if let inStock = viewModel?.inStock, inStock == true {
            lblName.textColor = .darkText
            lblPrice.textColor = .darkText
            lblOutOfStock.textColor = .darkText
            lblOutOfStock.text =  Constants.Strings.HomeScene.inStock
        }else{
            lblName.textColor = .lightGray
            lblPrice.textColor = .lightGray
            lblOutOfStock.textColor = .lightGray
            lblOutOfStock.text = Constants.Strings.HomeScene.outOfStock
        }
    }
    
    @IBAction func toggleRadioBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.radioButtonSelected( sender.isSelected, forSection: indexPath)
    }
    
    func setIconForRadioBtnState(_ enabled:Bool) {
        if enabled {
            radioButton.setBackgroundImage(#imageLiteral(resourceName: "radioActive"), for: .normal)
        }else{
            radioButton.setBackgroundImage(#imageLiteral(resourceName: "radioInactive"), for: .normal)
        }
    }

}

