//
//  CircleDescriptionCollectionViewCell.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/3/21.
//

import UIKit

class CircleDescriptionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    static let identifier = "CircleDescriptionCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.descriptionView.round(3)
        }
    }
    
    func bindingUI(data: HyperCircleData, showPercentage: Bool = true ) {
        descriptionView.backgroundColor = data.color
        titleLabel.text = data.description
        percentLabel.text = showPercentage ? "\(data.percent * 100)%" : ""
    }

}
