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
        
        let urlString = "https://api.thecatapi.com/v1/breeds"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            request.addValue("286bfc8c-5728-4980-a0d6-9ca223d384ab", forHTTPHeaderField: "x-api-key")
            URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) -> Void in}.resume()
            
            if let data = try? Data(contentsOf: url){
                let decoder = JSONDecoder()
                do{
                    let jsonBreeds = try decoder.decode([Breed].self, from: data)
                    breeds = jsonBreeds
                    tableView.reloadData()
                }
                catch{
                    showError(error)
                }
            }
        }
        
    }

    func showError(_ error: Error){
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading; please check your connection and try again. \(error.localizedDescription)", preferredStyle: .alert)
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
//***Will Continue - this will handle navigation from selected row to future detail screen**
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailViewController()
//        vc.detailItem =
//    }
}

