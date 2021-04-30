////
////  ImageCollectionViewCell.swift
////  photoFinder
////
////  Created by Paarth Agrawal on 25/04/21.
////
//

//  ImageCollectionViewCell.swift
//  photoFinder
//
//  Created by Paarth Agrawal on 25/04/21.

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "ImageCollectionViewCell"
    

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init (frame : CGRect){
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
     
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
//
    func configure(with urlstring : String){
        guard let url = URL(string: urlstring ) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self]data , _ , error in  guard let data = data , error == nil else {
            return
            }
        DispatchQueue.main.async {
            let image = UIImage(data: data )
            self?.imageView.image = image
            }
        }
        task.resume()
    }
}

