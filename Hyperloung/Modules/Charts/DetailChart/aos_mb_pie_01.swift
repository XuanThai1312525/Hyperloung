//
//  aos_mb_pie_01.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/2/21.
//

import UIKit

class aos_mb_pie_01: UIView {
    private var circleChart: HyperCircleChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        circleChart = HyperCircleChartView(frame: bounds)
        addSubview(circleChart)
        circleChart.fullscreen()
        circleChart.datasource = self
        layoutIfNeeded()
        DispatchQueue.main.async {
            self.circleChart.drawChart()
        }
    }
}

extension aos_mb_pie_01: HyperCircleDataSource {
    var internalDescription: (String, UIColor)? {
        return ("36%", .black)
    }
    
    var lineWidth: CGFloat {
        return 8
    }
    
    var dataSet: [HyperCircleData] {
        return [HyperCircleData(percent: 0.3, color: .red)]
    }
    
    func description(of data: HyperCircleData) -> String {
        return "12억"
    }
}
