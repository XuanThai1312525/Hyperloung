//
//  ReportCollectionViewCell.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class ReportCollectionViewCell: UICollectionViewCell {
    let reportCardView = UIView.makeFromXib(ReportCardView.self)
    static let identifier = "ReportCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reportCardView)
        reportCardView.fullscreen()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
