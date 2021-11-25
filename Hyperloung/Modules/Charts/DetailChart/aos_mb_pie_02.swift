//
//  aos_mb_pie_02.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/3/21.
//

import UIKit
import Charts

class aos_mb_pie_02: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var chartDescriptionCollectionview: UICollectionView!
    @IBOutlet weak var circleChartView: HyperCircleChartView!
    
    var data = [
        HyperCircleData(value: 0.38, color: #colorLiteral(red: 0.2078431373, green: 0.3411764706, blue: 0.7882352941, alpha: 1), percent: 0.38, description: "솔루션"),
        HyperCircleData(value: 0.22, color: #colorLiteral(red: 0.1215686275, green: 0.5725490196, blue: 0.8941176471, alpha: 1), percent: 0.22, description: "솔루션"),
        HyperCircleData(value: 0.18, color: #colorLiteral(red: 0.3803921569, green: 0.8156862745, blue: 0.9411764706, alpha: 1), percent: 0.18, description: "솔루션"),
        HyperCircleData(value: 0.10, color: #colorLiteral(red: 0.2941176471, green: 0.7725490196, blue: 0.7647058824, alpha: 1), percent: 0.10, description: "솔루션"),
        HyperCircleData(value: 0.12, color: #colorLiteral(red: 0.4941176471, green: 0.8745098039, blue: 0.6431372549, alpha: 1), percent: 0.12, description: "솔루션")
    ]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        Bundle.main.loadNibNamed("aos_mb_pie_02", owner: self, options: nil)
//        addSubview(view)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.fullscreen()
//        layoutIfNeeded()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.setupView()
//        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        chartDescriptionCollectionview.delegate = self
        chartDescriptionCollectionview.dataSource = self
        chartDescriptionCollectionview.register(UINib(nibName: CircleDescriptionCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CircleDescriptionCollectionViewCell.identifier)
        circleChartView.datasource = self
        circleChartView.drawChart()
    }
}

extension aos_mb_pie_02: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleDescriptionCollectionViewCell.identifier, for: indexPath) as! CircleDescriptionCollectionViewCell
        cell.bindingUI(data: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 15)
    }
}

extension aos_mb_pie_02: HyperCircleDataSource {
    var borderColor: UIColor? {
        nil
    }
    
    var shadowColor: UIColor? {
        nil
    }
    
    var centerTextAppearnce: HyperCircleCenterTextAppearance? {
        HyperCircleCenterTextAppearance(prefix: "+9993", suffix: "억", prefixColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), suffixColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), prefixFont: FontFamily.customFont.displayFontWithSize(24, attributeType: .bold), suffixFont: FontFamily.customFont.displayFontWithSize(16, attributeType: .light))
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
        nil
    }
    
}
