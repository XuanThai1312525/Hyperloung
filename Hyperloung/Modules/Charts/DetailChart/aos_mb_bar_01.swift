//
//  aos_mb_bar_01.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/2/21.
//

import UIKit

class aos_mb_bar_01: UIView {

    private var barChartView: HyperBarChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        barChartView = HyperBarChartView(frame: bounds)
        addSubview(barChartView)
        barChartView.fullscreen()
        barChartView.datasource = self
        layoutIfNeeded()
        DispatchQueue.main.async {
            self.barChartView.internalDraw()
        }
    }
    
}

extension aos_mb_bar_01: HyperChartDataSource {
    func dataSet() -> [HyperBarChartData] {
        return  [
            HyperBarChartData(focus: false, value: 40),
            HyperBarChartData(focus: false, value: 70),
            HyperBarChartData(focus: true, value: 100, tooltipText: "150")
        ]
    }
    
    var spaceBetweenRow: CGFloat {
        return 24
    }
    
    func description(of data: HyperBarChartData) -> String {
        return "사업계획"
    }
    
    var anchorPoint: HyperBarChartData {
        HyperBarChartData(focus: false, value: 100)
    }
    
    var appearance: HyperBarChartView.Appearance {
        HyperBarChartView.Appearance(highlightColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), normalColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), shouldSeparateHighlightRow: true, shouldShowDetailDescription: true, tooltipStyle: .hasBackground(color: .white))
    }
    
}
