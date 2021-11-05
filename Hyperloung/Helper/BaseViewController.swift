//
//  BaseViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/25/21.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVỉew()
    }
    
    private func setupVỉew() {
        backButton?.did(.touchUpInside, handler: {[weak self] (_, _) in
            guard let _self = self else {return}
            _self.didTapBackButton()
        })
    }
    
    func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
  
}

extension BaseViewController: HasAppProperties {}
