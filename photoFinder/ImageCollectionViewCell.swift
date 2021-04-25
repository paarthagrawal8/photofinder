//
//  ImageCollectionViewCell.swift
//  photoFinder
//
//  Created by Paarth Agrawal on 25/04/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    
    private let imageView : UICollectionView = {
        imageView.ClipToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init (frame:CGReact){
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    required init?(code : NSCoder) {
        fatalError()
    }
    override func layoutSubviews(){
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        
    }
    override func preapreForReuse(){
        super.preapreForReuse()
        imageView.image = nil
    }
    func configure(with urlString : string)  {
        
        guard let url = URL(string : urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with : url) {(data , _ , error in
         guard let data = data , error , error == nil else
            return
                )
            DispatchQueue.main.assync{
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
        }
        task.resume()
        
    }
    
}
