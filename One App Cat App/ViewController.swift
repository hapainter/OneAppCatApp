//
//  ViewController.swift
//  One App Cat App
//
//  Created by Holly Painter on 10/4/19.
//  Copyright © 2019 Holly Painter. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var breeds = [Breed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.thecatapi.com/v1/breeds?api_key=286bfc8c-5728-4980-a0d6-9ca223d384ab"
//        let session = URLSession.shared
//        let headers = ["x-api-key": "286bfc8c-5728-4980-a0d6-9ca223d384ab"]
//        let url = URL(string: urlString)!
//        var request = URLRequest(url: url)
//
//        request.addValue("application/json", forHTTPHeaderField: "headers")
//
//        let headers = ["x-api-key": "286bfc8c-5728-4980-a0d6-9ca223d384ab"]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.thecatapi.com/v1/breeds?attach_breed=0")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//          if (error != nil) {
//            print(error)
//          } else {
//            let httpResponse = response as? HTTPURLResponse
//            print(httpResponse)
//          }
//        })
//
//        dataTask.resume()
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonBreeds = try? decoder.decode(Breeds.self, from: json){
            breeds = jsonBreeds.results
            tableView.reloadData()
        }
    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let breed = breeds[indexPath.row]
        cell.textLabel?.text = breed.name
        cell.detailTextLabel?.text = breed.origin
        
        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailViewController()
//        vc.detailItem =
//    }
}

