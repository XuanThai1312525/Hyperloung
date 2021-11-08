//
//  aos_d_bar_01.swift
//  Hyperloung
//

import UIKit

class aos_d_bar_07: UIView {
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var chartNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        chartNameLabel.text = "aos_d_bar_07"
    }
    
    func setupUI() {
        let barChartView: VeriticalBarGroupChartView = VeriticalBarGroupChartView()
        barChartView.clipsToBounds = false
        chartContainerView.addSubview(barChartView)
        barChartView.centralize()
        barChartView.setHeight(190)

        let months = ["Text", "Text", "Text"]
        let unitsSold = [26, 30, 65.0]
        let unitsBought = [22.3, 68.0, 60]

        barChartView.setData(titles: months, colors: [#colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)], labels: ["범례1", "범례2"], items: [unitsSold, unitsBought], valueTitleList: [[],["22.3억", "812억", "452억"]])
    }
}
