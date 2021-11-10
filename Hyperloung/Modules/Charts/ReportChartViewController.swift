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

        // These line of code auto insert to TOP
        let bar_01: aos_d_bar_01 = .fromNib()
        chartContainerStackView.insertArrangedSubview(bar_01, at: 0)
        bar_01.setHeight(292)
        
        let bar_02: aos_d_bar_02 = .fromNib()
        chartContainerStackView.insertArrangedSubview(bar_02, at: 1)
        bar_02.setHeight(292)

        
        let bar_03: aos_d_bar_03 = .fromNib()
        chartContainerStackView.insertArrangedSubview(bar_03, at: 2)
        bar_03.setHeight(292)

        
        let bar_04: aos_d_bar_04 = .fromNib()
        chartContainerStackView.insertArrangedSubview(bar_04, at: 3)
        bar_04.setHeight(300)

        let bar_06: aos_d_bar_06 = .fromNib()
        chartContainerStackView.insertArrangedSubview(bar_06, at: 4)
        bar_06.setHeight(292)

        
        let bar_07: aos_d_bar_07 = .fromNib()
        chartContainerStackView.insertArrangedSubview(bar_07, at: 5)
        bar_07.setHeight(292)
        
        let mb_bar_01: aos_mb_bar_01_ = .fromNib()
        chartContainerStackView.insertArrangedSubview(mb_bar_01, at: 6)
        mb_bar_01.setHeight(292)

        let mb_bar_02: aos_mb_bar_02_ = .fromNib()
        chartContainerStackView.insertArrangedSubview(mb_bar_02, at: 7)
        mb_bar_02.setHeight(292)

        let mb_bar_03: aos_mb_bar_03_ = .fromNib()
        chartContainerStackView.insertArrangedSubview(mb_bar_03, at: 8)
        mb_bar_03.setHeight(292)

        let mb_bar_04: aos_mb_bar_04_ = .fromNib()
        chartContainerStackView.insertArrangedSubview(mb_bar_04, at: 9)
        mb_bar_04.setHeight(292)
        
        let aos_mb_bar_05: aos_mb_bar_05 = .fromNib()
        chartContainerStackView.insertArrangedSubview(aos_mb_bar_05, at: 10)
        aos_mb_bar_05.setHeight(292)
        
        let aos_mb_bar_06: aos_mb_bar_06 = .fromNib()
        chartContainerStackView.insertArrangedSubview(aos_mb_bar_06, at: 11)
        aos_mb_bar_06.setHeight(292)
        
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
