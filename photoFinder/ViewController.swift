//
//  ViewController.swift
//  photoFinder
//
//  Created by Paarth Agrawal on 19/04/21.
//

import UIKit

struct APIResponse: Codable {
    let total: Int
    let total_pages : Int
    let results:[Result]
}

struct Result : Codable{
    let id : String
    let urls : URLS
    }

struct URLS: Codable{
    let regular: String
}


class ViewController: UIViewController , UICollectionViewDataSource{
    
    let urlstring  = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=office&client_id=-m__cHmERkdS79ipLOHoaKESobSwI9GD2MVwnwWqs6o"
    
    private var collectionview : UICollectionView?
    
    var results : [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        let collectionview = UICollectionView(frame: .zero , collectionViewLayout : layout)
        
        collectionview.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionview.dataSource = self
        view.addSubview(collectionview)
        self.collectionview = collectionview
        fetchphotos()
        }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionview?.frame = view.bounds
    }
    func fetchphotos() {
        guard let url = URL(string: urlstring) else {
            return
            }
        let task = URLSession.shared.dataTask(with: url) {[weak self]data , _ , error in  guard let data = data , error == nil else {
            return
            }
        do {
            let jsonresult = try JSONDecoder().decode(APIResponse.self , from: data)
            DispatchQueue.main.async {
                self?.results = jsonresult.results
                self?.collectionview?.reloadData()
                }
            }

        catch {
        print(error)
            }
        }
        task.resume()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageurlstring = results[indexPath.row].urls.regular
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(with: imageurlstring)
        return cell
    }
    
}
    
        // Do any additional setup after loading the view.
    

        
    
  
