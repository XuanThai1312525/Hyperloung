//
//  aos_mb_pie_01.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/2/21.
//

import UIKit
import Charts

class aos_mb_pie_01: UIView {
    var circleChartView: HyperCircleChartView!
    @IBOutlet var view: UIView!
    var data = [
        HyperCircleData(percent: 0.5, color: #colorLiteral(red: 0.2078431373, green: 0.3411764706, blue: 0.7882352941, alpha: 1), description: "솔루션"),
        HyperCircleData(percent: 0.5, color: #colorLiteral(red: 0.1215686275, green: 0.5725490196, blue: 0.8941176471, alpha: 1), description: "솔루션"),
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("aos_mb_pie_01", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fullscreen()
        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setupView()
        }
    }
    
    private func setupView() {
        circleChartView = HyperCircleChartView(frame: bounds)
        addSubview(circleChartView)
        circleChartView.fullscreen()
        circleChartView.datasource = self
        circleChartView.drawChart()
    }
}

extension aos_mb_pie_01: HyperCircleDataSource {
    var dataSet: [HyperCircleData] {
        data
    }
    
    func description(of data: HyperCircleData) -> String {
        data.description ?? ""
    }
    
    var lineWidth: CGFloat {
        10
    }
    
    var centerText: (String, UIColor)? {
        ("346억", .black)
    }
    
    
}
