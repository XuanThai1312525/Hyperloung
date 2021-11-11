//
//  HyperHorizontalLineChartView.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/27/21.
//

import UIKit

class HyperHorizontalLineChartView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var ucRowView: HyperRowView!
    @IBOutlet weak var firstRowView: HyperRowView!
    @IBOutlet weak var secondRowView: HyperRowView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("HyperHorizontalLineChartView", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fullscreen()
        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.bindingUI()
        }
    }
    
    func bindingUI() {
    
        ucRowView.data = HyperHorizontalData(total: 5, current: 3, unit: "명")
        ucRowView.appearance = HyperRowView.Appearance(highlightColor: #colorLiteral(red: 0, green: 0.4588235294, blue: 0.8901960784, alpha: 1), backgroundColor: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 0.7204294773), showHighlightText: true, trailingSpace: 8, descriptionWidth: 70, trailingDescription: "100%", leadingSpace: 40, leadingDescription: "UC", highlightDescription: "32명")
        ucRowView.drawChart()
        firstRowView.data = HyperHorizontalData(total: 5, current: 3, unit: "명")
        firstRowView.appearance = HyperRowView.Appearance(highlightColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), backgroundColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 0.7204294773), showHighlightText: true, trailingSpace: 8, descriptionWidth: 70, trailingDescription: "", leadingSpace: 40, leadingDescription: "최대글자", leadingTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1))
        firstRowView.drawChart()
 
        secondRowView.data = HyperHorizontalData(total: 5, current: 3, unit: "명")
        secondRowView.appearance = HyperRowView.Appearance(highlightColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1), backgroundColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 0.7204294773), showHighlightText: true, trailingSpace: 8, descriptionWidth: 70, trailingDescription: "", leadingSpace: 40, leadingDescription: "경관", leadingTextColor: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1))
        secondRowView.drawChart()
    }
}

struct LineChartData {
    var title: String
    var data: HyperHorizontalData
}

class MultiLineChartView: UIView {
    private let stackView = UIStackView()
    var data: [LineChartData] = [
        LineChartData(title: "영업1", data: HyperHorizontalData(total: 543, current: 543, unit: "억")),
        LineChartData(title: "영업2", data: HyperHorizontalData(total: 543, current: 234, unit: "억")),
        LineChartData(title: "영업3", data: HyperHorizontalData(total: 543, current: 168, unit: "억")),
        LineChartData(title: "AI", data: HyperHorizontalData(total: 543, current: 431, unit: "억")),
        LineChartData(title: "보안", data: HyperHorizontalData(total: 543, current: 302, unit: "억"))
    ]
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutIfNeeded()
        DispatchQueue.main.async {
            self.setupView()
        }
    }
    
    private func setupView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        addSubview(stackView)
        stackView.fullscreen()
        
        var appearance = HyperRowView.Appearance(lineHeight: 8, highlightColor: .black, backgroundColor: .clear, showHighlightText: false, trailingSpace: 10, descriptionWidth: 48, cornerRadius: 4, highlightCorners: .allCorners, leadingSpace: 70)
        data.forEach { chartData in
            let rowView = HyperRowView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 20))
            appearance.leadingDescription = chartData.title
            appearance.trailingDescription = "\(chartData.data.current)억"
            rowView.data = chartData.data
            rowView.appearance = appearance
            rowView.drawChart()
            stackView.addArrangedSubview(rowView)
        }
    }
}
