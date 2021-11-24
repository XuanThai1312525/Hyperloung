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
    @IBOutlet weak var circleChartView2: HyperCircleChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // These line of code auto insert to TOP
        let bar_01: aos_d_bar_01 = .fromNib()
        chartContainerStackView.addArrangedSubview(bar_01)
        bar_01.setHeight(292)

        let bar_02: aos_d_bar_02 = .fromNib()
        chartContainerStackView.addArrangedSubview(bar_02)
        bar_02.setHeight(292)


        let bar_03: aos_d_bar_03 = .fromNib()
        chartContainerStackView.addArrangedSubview(bar_03)
        bar_03.setHeight(292)


        let bar_04: aos_d_bar_04 = .fromNib()
        chartContainerStackView.addArrangedSubview(bar_04)
        bar_04.setHeight(300)

        let bar_06: aos_d_bar_06 = .fromNib()
        chartContainerStackView.addArrangedSubview(bar_06)
        bar_06.setHeight(292)


        let bar_07: aos_d_bar_07 = .fromNib()
        chartContainerStackView.addArrangedSubview(bar_07)
        bar_07.setHeight(292)

        let mb_bar_01: aos_mb_bar_01_ = .fromNib()
        chartContainerStackView.addArrangedSubview(mb_bar_01)
        mb_bar_01.setHeight(292)

        let mb_bar_02: aos_mb_bar_02_ = .fromNib()
        chartContainerStackView.addArrangedSubview(mb_bar_02)
        mb_bar_02.setHeight(292)

        let mb_bar_03: aos_mb_bar_03_ = .fromNib()
        chartContainerStackView.addArrangedSubview(mb_bar_03)
        mb_bar_03.setHeight(292)

        let mb_bar_04: aos_mb_bar_04_ = .fromNib()
        chartContainerStackView.addArrangedSubview(mb_bar_04)
        mb_bar_04.setHeight(292)
//
        let aos_mb_bar_05: aos_mb_bar_05 = .fromNib()
        chartContainerStackView.addArrangedSubview(aos_mb_bar_05)
        aos_mb_bar_05.setHeight(292)
        
        let aos_mb_bar_06: aos_mb_bar_06 = .fromNib()
        chartContainerStackView.addArrangedSubview(aos_mb_bar_06)
        aos_mb_bar_06.setHeight(292)
        
    }
    
    private func setupView() {
      
    }
}

class HyperCircleHander: HyperCircleDataSource {
    private var isMinusData: Bool
    init(isMinusData: Bool) {
        self.isMinusData = isMinusData
    }
    
    var borderColor: UIColor? {
        isMinusData ? UIColor.red : #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1)
    }
    
    var shadowColor: UIColor? {
        isMinusData ? UIColor.red : #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1)
    }
    
    var dataSet: [HyperCircleData] {
        if isMinusData {
           return [HyperCircleData(value: 36, color: UIColor.red),
            HyperCircleData(value: 64, color: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1))]
        }
        
        return   [HyperCircleData(value: 68, color: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1)),
                  HyperCircleData(value: 32, color: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1))]
    }
    
    func description(of data: HyperCircleData) -> String {
        ""
    }
    
    var lineWidth: CGFloat {
        return 10
    }
    
    var tooltip: NSAttributedString? {
        nil
    }
    
    var centerTextAppearnce: HyperCircleCenterTextAppearance? {
        return  HyperCircleCenterTextAppearance(prefix: isMinusData ? "32%" : "68%", suffix: "", prefixColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), suffixColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), prefixFont: FontFamily.customFont.displayFontWithSize(24, attributeType: .bold), suffixFont: FontFamily.customFont.displayFontWithSize(16, attributeType: .light))
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
