//
//  BottomBar.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

protocol BottomBarDelegate: AnyObject {
    func didTapToLeftButton()
    func didTapToRightButton()
    func didTapToCenterButton()
}

class BottomBar: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    weak var delegate: BottomBarDelegate?
    
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
        
        leftButton.did(.touchUpInside) {[weak self] _, _ in
            self?.delegate?.didTapToLeftButton()
        }
        
        rightButton.did(.touchUpInside) {[weak self] _, _ in
            self?.delegate?.didTapToRightButton()
        }
        
        centerButton.did(.touchUpInside) {[weak self] _, _ in
            self?.delegate?.didTapToCenterButton()
        }
    }
    
}
    
