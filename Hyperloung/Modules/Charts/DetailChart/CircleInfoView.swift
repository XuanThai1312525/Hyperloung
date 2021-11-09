//
//  CircleDescriptionCollectionViewCell.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/3/21.
//

import UIKit
struct CircleInfoData {
    var color: UIColor
    var description: String
    var descriptionColor: UIColor? = "#888888".color
}

class CircleInfoView: UIView {
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindingUI(data: CircleInfoData) {
        descriptionView.backgroundColor = data.color
        descriptionLabel.text = data.description
        descriptionLabel.textColor = data.descriptionColor
    }

}
