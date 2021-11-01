//
//  BottomBar.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class BottomBar: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("BottomBar", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fullscreen()
        setupUI()
    }
    
    private func setupUI() {
        layoutIfNeeded()
        DispatchQueue.main.async {
            self.numberLabel.round(self.numberLabel.frame.height / 2)
        }
    }
}
    
