//
//  SummaryReportView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/25/21.
//

import UIKit

class SummaryReportView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var checkListView: UIView!
    @IBOutlet weak var reportView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("SummaryReportView", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fullscreen()
        setupUI()
        layoutIfNeeded()
        DispatchQueue.main.async {
//            self.round(12)
            self.containerView.round(12)
        }
    }
    
    private func setupUI() {
        checkListView.round(12)
        reportView.round(12)
        backgroundColor = .clear
    }
}
