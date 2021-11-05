//
//  ReportCollectionViewCell.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class ReportCollectionViewCell: UICollectionViewCell {
    var reportCardView: ReportCardView!
    static let identifier = "ReportCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        reportCardView = UIView.makeFromXib(ReportCardView.self)
        addSubview(reportCardView)
        reportCardView.fullscreen()
        reportCardView.round(12)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
