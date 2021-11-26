//
//  ChartListViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/18/21.
//

import UIKit

class ChartListViewController: BaseViewController {
    @IBOutlet weak var chartTableView: UITableView!
    var sessionTitles: [String] = ["DataType", "MessageTypeB"]
    var dataTypeData: [String] = ["d_bar_01", "d_bar_02", "d_bar_03", "d_bar_04", "d_bar_05", "d_bar_06", "d_bar_07", "d_bar_08", "d_pie_01", "d_pie_02", "d_line_01", "d_line_02", "d_bar_09"]
    
    var messageTypeB: [String] = ["mb_bar_01", "mb_bar_02", "mb_bar_03", "mb_bar_04", "mb_bar_05", "mb_bar_06", "mb_bar_07", "mb_pie_01", "mb_pie_02", "mb_line_01", "mb_line_02", "mb_line_03", "mb_line_04",
                                  
                                  
                                  
                                  
                                  "mb_bar_08", "mb_bar_09", "mb_bar_10", "mb_bar_11", "mb_bar_12", "mb_bar_13", "mb_pie_03", "mb_pie_04", "mb_line_05", "mb_line_06" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ChartListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = indexPath.section == 0 ? dataTypeData[indexPath.row] : messageTypeB[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = text
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? dataTypeData.count : messageTypeB.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel(frame:  CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        label.text = sessionTitles[section]
        headerView.addSubview(label)
        headerView.backgroundColor = #colorLiteral(red: 0.403813839, green: 0.5812723637, blue: 0.9351559281, alpha: 0.7613538527)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            showDetailMessageOfDataType(number: indexPath.row)
        } else {
            showDetailMessageOfTypeB(number: indexPath.row)
        }
        
    }
    
    private func showDetailMessageOfTypeB(number: Int) {
        let vc = UIViewController.make(DemoViewController.self)
        vc.chartType = .messageTypeB(number)
        vc.chartTitle = messageTypeB[number]
        present(vc, animated: false, completion: nil)
    }
    
    private func showDetailMessageOfDataType(number: Int) {
        let vc = UIViewController.make(DemoViewController.self)
        vc.chartType = .dataType(number)
        vc.chartTitle = dataTypeData[number]
        present(vc, animated: false, completion: nil)
    }
    
}
