//
//  ViewController.swift
//  photoFinder
//
//  Created by Paarth Agrawal on 19/04/21.
//

import UIKit

struct apiresponse: Codable {
    let total: Int
    let total_pages : Int
    let results:[Result]
}

struct Result : Codable{
    let id : String
    let urls : URLS
    }
struct URLS: Codable {
    let full: String
    
}
class ViewController: UIViewController {
    let urlstring  = "https://api.unsplash.com/search/collections?page=50&query=office&client_id=-m__cHmERkdS79ipLOHoaKESobSwI9GD2MVwnwWqs6o"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchphotos()
        }
        
    func fetchphotos() {
        guard let url = URL(string: urlstring) else {
            return
            }
        let task = URLSession.shared.dataTask(with: url) {data , _ , error in  guard let data = data , error == nil else {
            return
            }
        do {
            let jsonresults = try JSONDecoder().decode(apiresponse.self, from: data)
            print(jsonresults.results.count)
            }

        catch {
        print(error)
            }
        };task.resume()
    }
}
    
        // Do any additional setup after loading the view.
    

        
    
    



