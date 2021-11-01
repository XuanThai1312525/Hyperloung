//
//  ReportChartViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class ReportChartViewController: BaseViewController {

    @IBOutlet weak var monthChartView: HyperBarChartView!
    @IBOutlet weak var planChartView: HyperBarChartView!
    @IBOutlet weak var circleChartView: HyperCircleChartView!
    @IBOutlet weak var linkedChartView: LinkedChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        monthChartView.datasource = self
        monthChartView.internalDraw()
        let dataSource = HyperHandleBarChartData()
        planChartView.datasource = dataSource
        planChartView.internalDraw()
        let circleDatasource = HyperHandleCircleChart()
        circleChartView.datasource = circleDatasource
        circleChartView.drawChart()
        let linkedChartDataSourceHandler = LinkedChartDataSourceHandler()
        linkedChartView.datasource = linkedChartDataSourceHandler
        linkedChartView.drawChart()
    }
}

extension ReportChartViewController: HyperChartDataSource {
    func dataSet() -> [HyperBarChartData] {
        return [
            HyperBarChartData(focus: true, value: 40),
            HyperBarChartData(focus: false, value: 70),
            HyperBarChartData(focus: true, value: -100),
            HyperBarChartData(focus: true, value: 100),
            HyperBarChartData(focus: false, value: 80),
            HyperBarChartData(focus: true, value: -20),
        ]
    }
    
    var spaceBetweenRow: CGFloat {
        return 20
    }
    
    func description(of data: HyperBarChartData) -> String {
        return "예상매출"
    }
    
    var hightlightColor: UIColor {
        return .red
    }
    
    var anchorPoint: HyperBarChartData {
        return HyperBarChartData(focus: false, value: 100)
    }
    
}

class HyperHandleCircleChart {}
extension HyperHandleCircleChart: HyperCircleDataSource {
    var internalDescription: (String, UIColor)? {
        return ("36%", .black)
    }
    
    var dataSet: [HyperCircleData] {
        return [HyperCircleData(percent: 0.3)]
    }
    
    func color(of data: HyperCircleData) -> UIColor {
        return .red
    }
    
    func description(of data: HyperCircleData) -> String {
        return "12억"
    }
    
    var lineWidth: CGFloat {
        return 20
    }
    
}

class HyperHandleBarChartData {}

extension HyperHandleBarChartData: HyperChartDataSource {
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
