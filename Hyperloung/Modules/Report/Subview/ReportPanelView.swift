//
//  ReportPanelView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class ReportPanelView: UIView {
    @IBOutlet var view: UIView!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("ReportPanelView", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fullscreen()
        layoutIfNeeded()
        DispatchQueue.main.async {
            self.round(12)
        }
    }
}
