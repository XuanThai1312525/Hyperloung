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
    @IBOutlet weak var detailReportView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topbarConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomBarContraintHeight: NSLayoutConstraint!
    @IBOutlet weak var moreButton: UIButton!
    
    private var topbarContraintHeightInit: CGFloat = 0
    private var bottomBarContraintHeightInit: CGFloat = 0
    private let mainReportViewController = UIViewController.make(MainReportViewController.self)
    private let detailReportViewController = UIViewController.make(DetailReportViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
 
    private func setupUI() {
        bottomBar.round(32)
        addMainReportChildView()
        addDetailReportChildView()
        topbarContraintHeightInit = topbarConstraintHeight.constant
        bottomBarContraintHeightInit = bottomBarContraintHeight.constant
        bottomBar.delegate = self
        
        moreButton.did(.touchUpInside) {[weak self] _, _ in
            self?.navigator.showProfileViewController(NavigationContext().fromVC(self))
        }
    }
    
    private func addMainReportChildView() {
        addChild(mainReportViewController)
        mainReportView.addSubview(mainReportViewController.view)
        mainReportViewController.view.fullscreen()
        mainReportViewController.didMove(toParent: self)
        mainReportViewController.delegate = self
    }
    
    private func addDetailReportChildView() {
        addChild(detailReportViewController)
        detailReportView.addSubview(detailReportViewController.view)
        detailReportViewController.view.fullscreen()
        detailReportViewController.didMove(toParent: self)
        detailReportViewController.delegate = self
    }
}

extension HomeViewController: BottomBarDelegate {
    func didTapToLeftButton() {
        if !mainReportView.isHidden {return}
        mainReportView.isHidden = false
        centerView.isHidden = true
        detailReportView.isHidden = true
    }
    
    func didTapToRightButton() {
        if !detailReportView.isHidden {return}
        mainReportView.isHidden = true
        centerView.isHidden = true
        detailReportView.isHidden = false
    }
    
    func didTapToCenterButton() {
        if !centerView.isHidden {return}
        mainReportView.isHidden = true
        centerView.isHidden = false
        detailReportView.isHidden = true
    }
}

extension HomeViewController: ReportViewControllerDelegate {
    func shouldExpandView(ofsset: CGFloat) {
        topbarConstraintHeight.constant = topbarContraintHeightInit - ofsset
        bottomBarContraintHeight.constant = bottomBarContraintHeightInit - ofsset
    }
}
