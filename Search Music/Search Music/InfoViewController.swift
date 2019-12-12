//
//  InfoViewController.swift
//  Search Music
//
//  Created by mabookpro4 on 12/11/19.
//  Copyright © 2019 mabookpro4. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var contentPrice: UILabel!
    
    
    var album: Album!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        updateLabels()
    }

    func updateLabels () {
        artistName.text = album.artistName
        albumImage.image = image
        contentPrice.text = album.contentPrice
    }
    
    
}
