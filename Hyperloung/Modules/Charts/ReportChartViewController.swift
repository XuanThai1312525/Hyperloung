//
//  ReportChartViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class ReportChartViewController: BaseViewController {
    
    @IBOutlet weak var chartContainerStackView: UIStackView!
    @IBOutlet weak var monthChartView: aos_mb_bar_01!
    @IBOutlet weak var planChartView: HyperBarChartView!
    @IBOutlet weak var circleChartView: aos_mb_pie_01!
    @IBOutlet weak var linkedChartView: LinkedChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        insertChartView_aos_d_bar_07()
        insertChartView_aos_d_bar_06()
        insertChartView_aos_d_bar_04()
        insertChartView_aos_d_bar_03()
        insertChartView_aos_d_bar_02()
        insertBarChart_aos_d_bar_01()
        
    }
    
    private func setupView() {
        let dataSource = HyperHandleBarChartData()
        planChartView.datasource = dataSource
        planChartView.internalDraw()

        let linkedChartDataSourceHandler = LinkedChartDataSourceHandler()
        linkedChartView.datasource = linkedChartDataSourceHandler
        linkedChartView.drawChart()
    }
}

class HyperHandleBarChartData {}

extension HyperHandleBarChartData: HyperChartDataSource {
    var appearance: HyperBarChartView.Appearance {
        HyperBarChartView.Appearance()
    }
    
    func dataSet() -> [HyperBarChartData] {
        return [
            HyperBarChartData(focus: false, value: 70),
            HyperBarChartData(focus: true, value: 60),
            HyperBarChartData(focus: false, value: 70),
        ]
    }
    
    var spaceBetweenRow: CGFloat {
        return 30
    }
    
    func description(of data: HyperBarChartData) -> String {
        return "UC"
    }
    
    var hightlightColor: UIColor {
        .red
    }
    
    var anchorPoint: HyperBarChartData {
        HyperBarChartData(focus: false, value: 70)
    }
}

class LinkedChartDataSourceHandler {}
extension LinkedChartDataSourceHandler: LinkedDataSource {
    func numberOfChart(_ chart: LinkedChartView) -> Int {
        1
    }
    
    func dataForChart(_ chart: LinkedChartView, section: Int) -> [LinkedChartData] {
        return [
            LinkedChartData(value: 20),
            LinkedChartData(value: 60),
            LinkedChartData(value: 75),
            LinkedChartData(value: 80),
        ]
    }
    
    var anchorPoint: LinkedChartData {
        LinkedChartData(value: 0)
    }
    
    func appearance(_ for: LinkedChartView) -> LinkedChartView.Appearance {
        return LinkedChartView.Appearance()
    }
}
