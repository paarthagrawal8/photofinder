//
//  ViewController.swift
//  photoFinder
//
//  Created by Paarth Agrawal on 19/04/21.
//

import UIKit

struct APIResponse: Codable {
//    let total: Int
//    let total_pages : Int
    let results:[Result]
}

struct Result : Codable{
    let id : String
    let urls : URLS
    }

struct URLS: Codable{
    let regular: String
}


class ViewController: UIViewController , UICollectionViewDataSource , UISearchBarDelegate {
    
    
    
   // @IBOutlet weak var collectionView: UICollectionView!
    
//    @IBOutlet weak var info: UILabel!
    
     private var collectionview : UICollectionView?
    
    var results : [Result] = []
//
    private var images : [String : Data] = [:]
   
    
    let searchbar = UISearchBar()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        view.addSubview(searchbar)
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        let collectionview = UICollectionView(frame: .zero , collectionViewLayout : layout)
        collectionview.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionview.dataSource = self
        view.addSubview(collectionview)
        self.collectionview = collectionview
        fetchphotos(query: "login")
            
    }
        
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        
        
        if let text = searchbar.text {
            results = []
            collectionview?.frame = view.bounds
            let trimcharch = text.replacingOccurrences(of: " " , with: "")
            fetchphotos(query: trimcharch)
            
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchbar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width-20, height: 50)
        collectionview?.frame = CGRect(x: 0, y: view.safeAreaInsets.top+55, width: view.frame.size.width, height: view.frame.size.height-55)
    }
    
    
    func fetchphotos(query : String ) {
        let urlstring  = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=-m__cHmERkdS79ipLOHoaKESobSwI9GD2MVwnwWqs6o"

        guard let url = URL(string: urlstring) else {
            return
            }
        let task = URLSession.shared.dataTask(with: url) {data , _ , error in  guard let data = data , error == nil else {
            return
            }
        do {
            let jsonresult = try JSONDecoder().decode(APIResponse.self , from: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(2)) {
                self.results = jsonresult.results
                self.collectionview?.reloadData()
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
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else
                {
                    return UICollectionViewCell()
                }
                cell.configure(with: imageurlstring)
                return cell
            }
    }

  
