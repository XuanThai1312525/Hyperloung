//
//  aos_mb_pie_01.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/2/21.
//

import UIKit
import Charts

class aos_mb_pie_01: UIView {
    @IBOutlet var circleChartView: HyperCircleChartView!
    @IBOutlet weak var descriptionView: UIView!
    
    var descriptionStackView = UIStackView()
    
    var data = [
        HyperCircleData(value: 134, color: #colorLiteral(red: 0.2078431373, green: 0.3411764706, blue: 0.7882352941, alpha: 1), percent: 45, description: "매출이익"),
        HyperCircleData(value: 212, color: #colorLiteral(red: 0.1215686275, green: 0.5725490196, blue: 0.8941176471, alpha: 1), percent: 55, description: "영업이익")
    ]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        Bundle.main.loadNibNamed("aos_mb_pie_01", owner: self, options: nil)
//        addSubview(view)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.fullscreen()
//        layoutIfNeeded()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.setupView()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        circleChartView.datasource = self
        circleChartView.drawChart()
        let cardWidth = frame.size.width / 2 - 50
        data.forEach { data in
            let cardView = HyperDescriptionCard(frame: .zero)
            descriptionView.setWidth(cardWidth)
            descriptionStackView.addArrangedSubview(cardView)
            cardView.data = data
        }
        descriptionStackView.spacing = 30
        descriptionView.addSubview(descriptionStackView)
        descriptionStackView
            .setCenterX(0, relativeToView: descriptionView)
            .setTop(0, relativeToView: descriptionView)
    }
}

extension aos_mb_pie_01: HyperCircleDataSource {
    var borderColor: UIColor? {
        nil
    }
    
    var shadowColor: UIColor? {
        nil
    }
    
    
    var dataSet: [HyperCircleData] {
        data
    }
    
    func description(of data: HyperCircleData) -> String {
        data.description ?? ""
    }
    
    var lineWidth: CGFloat {
        10
    }
    
    var tooltip: NSAttributedString? {
        nil
    }
    
    var centerTextAppearnce: HyperCircleCenterTextAppearance? {
        HyperCircleCenterTextAppearance(prefix: "346", suffix: "억", prefixColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), suffixColor: #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), prefixFont: FontFamily.customFont.displayFontWithSize(24, attributeType: .bold), suffixFont: FontFamily.customFont.displayFontWithSize(16, attributeType: .light))
    }
    
    var isShowLegend: Bool {
        true
    }
}

class HyperDescriptionCard: UIView {
    private let stackView = UIStackView()
    private let legendView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    private let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    private let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    var data: HyperCircleData! {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func reloadData() {
        legendView.backgroundColor = data.color
        titleLabel.text = data.description
        titleLabel.font = FontFamily.customFont.displayFontWithSize(12)
        let mutableAttributeString = NSMutableAttributedString()
            .addAtributes(for: "\(data.value)", attribute: [
                NSAttributedString.Key.font: FontFamily.customFont.displayFontWithSize(20, attributeType: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]).addAtributes(for: "억(\(Int(data.percent ?? 0))%)", attribute: [
                NSAttributedString.Key.font: FontFamily.customFont.displayFontWithSize(12, attributeType: .light),
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            ])
        descriptionLabel.attributedText = mutableAttributeString
        
    }
    
    private func setupView() {
        addSubview(stackView)
        stackView.setTop(0, relativeToView: self).setLeft(0, relativeToView: self).setRight(0, relativeToView: self)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        let firstHorizontalStackView = UIStackView()
        firstHorizontalStackView.axis = .horizontal
        firstHorizontalStackView.distribution = .fill
        firstHorizontalStackView.alignment = .center
        firstHorizontalStackView.spacing = 4
        legendView.round(3.5)
        legendView.setWidth(7).setHeight(7)
        descriptionLabel.font = FontFamily.customFont.displayFontWithSize(12)
        firstHorizontalStackView.addArrangedSubview(legendView)
        firstHorizontalStackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(firstHorizontalStackView)
        stackView.addArrangedSubview(descriptionLabel)
    }
}
