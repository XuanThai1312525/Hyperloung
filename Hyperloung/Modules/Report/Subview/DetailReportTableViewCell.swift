//
//  DetailReportTableViewCell.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class DetailReportTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var highlightView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    static let identifier = "DetailReportTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    private func setupView() {
        layoutIfNeeded()
        DispatchQueue.main.async {
            self.categoryView.round(self.categoryView.frame.height / 2)
            self.highlightView.round(4)
            self.containerView.round(18, color: #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1), width: 1)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
