//
//  DetailReportViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class DetailReportViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension DetailReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailReportTableViewCell.identifier, for: indexPath)
        
        return cell
    }
}
