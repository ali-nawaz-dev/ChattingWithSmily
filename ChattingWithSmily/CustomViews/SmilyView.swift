//
//  SmilyView.swift
//  testtt
//
//  Created by Sheikh Ali on 12/08/2021.
//

import UIKit

class SmilyView: UIView {

    @IBOutlet weak var collectionview: UICollectionView!
    
    var smilyIcons : [String] = ["smily6","smily5","smily4","smily3","smily2","smily1","smily6","smily5","smily4","smily3","smily2","smily1"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionview.register(UINib(nibName: "SmilyCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SmilyCollectionViewCell")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
    }
}

extension SmilyView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        smilyIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SmilyCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmilyCollectionViewCell", for: indexPath) as! SmilyCollectionViewCell
        cell.smilyImageView.image = UIImage.init(named: smilyIcons[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 40, height: 40)
    }
    
}

extension SmilyView {
    static let nibName = "SmilyView"
}
