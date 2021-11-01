//
//  HomeViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/25/21.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var bottomBar: BottomBar!
    @IBOutlet weak var mainReportView: UIView!
    
    private let mainReportViewController = UIViewController.make(MainReportViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
 
    private func setupUI() {
        bottomBar.round(32)
        addChild(mainReportViewController)
        mainReportView.addSubview(mainReportViewController.view)
        mainReportViewController.view.fullscreen()
        mainReportViewController.didMove(toParent: self)
    }
    
}
