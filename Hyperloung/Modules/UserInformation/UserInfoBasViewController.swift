//
//  UserInfoBasViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class UserInfoBasViewController: BaseViewController {

    @IBOutlet weak var avatarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        avatarView.round(12)
    }
}
