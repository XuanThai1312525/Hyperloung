//
//  HeaderFooterClass.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class HeaderFooterClass: UICollectionReusableView {
    
    @IBOutlet weak var summaryReportView: SummaryReportView!
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       // Customize here
//        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
  
}
