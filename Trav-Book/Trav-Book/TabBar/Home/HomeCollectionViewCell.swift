//
//  HomeCollectionViewCell.swift
//  Trav-Book
//
//  Created by Mohamed Mahmoud Zaki on 10/10/19.
//  Copyright © 2019 Mohamed Mahmoud Zaki. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBAction func likeButton(_ sender: Any) {
    }
    @IBAction func disLikeButton(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
