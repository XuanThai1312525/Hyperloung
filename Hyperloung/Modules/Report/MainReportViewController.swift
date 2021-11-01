//
//  MainReportViewController.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/26/21.
//

import UIKit

class MainReportViewController: BaseViewController {
    
    @IBOutlet weak var reportCollectionView: UICollectionView!
    private let itemPerRow: CGFloat = 2.0
    private let minimumSpace: CGFloat = 10.0
    private let collectionViewHeaderFooterReuseIdentifier = "HeaderFooterClass"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        reportCollectionView.register(UINib(nibName: collectionViewHeaderFooterReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:collectionViewHeaderFooterReuseIdentifier)
        reportCollectionView.register(ReportCollectionViewCell.self, forCellWithReuseIdentifier: ReportCollectionViewCell.identifier)
    }

}

extension MainReportViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {

        case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier, for: indexPath)

                return headerView

            default:
                assert(false, "Unexpected element kind")
            }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportCollectionViewCell.identifier, for: indexPath) as! ReportCollectionViewCell
        
        cell.reportCardView.iconImageView.isHidden = !(indexPath.item == 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if indexPath.item == 0 {
            print("[itemWidth] \(width)")
            return CGSize(width: width, height: width * 170 / 320)
        }
        let itemWidth = (width - minimumSpace) / itemPerRow
        print("[itemWidth] \(itemWidth)")
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 250)
    }
}

