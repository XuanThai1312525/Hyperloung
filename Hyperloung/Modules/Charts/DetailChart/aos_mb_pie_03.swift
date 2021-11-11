//
//  aos_mb_pie_03.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/3/21.
//

import UIKit
import Charts

class aos_mb_pie_03: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var chartDescriptionCollectionview: UICollectionView!
    @IBOutlet weak var circleChartView: HyperCircleChartView!
    
    var data = [
        HyperCircleData(value: 0.56, color: #colorLiteral(red: 0.1411764706, green: 0.4352941176, blue: 0.9333333333, alpha: 1), description: "범례최대글자"),
        HyperCircleData(value: 0.22, color: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1),  description: "범례"),
        HyperCircleData(value: 0.12, color: #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1), description: "범례영역"),
        HyperCircleData(value: 0.10, color: #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1), description: "기타"),
    ]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("aos_mb_pie_03", owner: self, options: nil)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fullscreen()
        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setupView()
        }
    }
    
    func setupView() {
        chartDescriptionCollectionview.delegate = self
        chartDescriptionCollectionview.dataSource = self
        chartDescriptionCollectionview.register(UINib(nibName: CircleDescriptionCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CircleDescriptionCollectionViewCell.identifier)
        
        circleChartView.datasource = self
        circleChartView.drawChart()
    }
}

extension aos_mb_pie_03: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleDescriptionCollectionViewCell.identifier, for: indexPath) as! CircleDescriptionCollectionViewCell
        cell.bindingUI(data: data[indexPath.row], showPercentage: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
}

extension aos_mb_pie_03: HyperCircleDataSource {
    var centerTextAppearnce: HyperCircleCenterTextAppearance? {
        HyperCircleCenterTextAppearance(textAttributedString: NSAttributedString(string: "180억", attributes: [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 22)]))
    }
    
    var centerText: (String, String, UIColor)? {
        ("180억","",UIColor.black)
    }
    
    
    var dataSet: [HyperCircleData] {
        data
    }
    
    func description(of data: HyperCircleData) -> String {
        data.description ?? "ABC"
    }
    
    var lineWidth: CGFloat {
        10
    }
    
    var tooltip: NSAttributedString? {
        NSAttributedString(string: "56%", attributes: [.foregroundColor: "#246FEE".color, .font: UIFont.boldSystemFont(ofSize: 14)])
    }
}
