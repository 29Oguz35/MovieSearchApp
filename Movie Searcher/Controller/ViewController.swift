//
//  ViewController.swift
//  Movie Searcher
//
//  Created by naruto kurama on 27.04.2022.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
  
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.idenfier)
        
        field.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    func searchMovie() {
        field.resignFirstResponder()
        
        guard let txt = field.text , !txt.isEmpty else { return }
        
        movies.removeAll()
        
        let urlString = "https://www.omdbapi.com/?apikey=bc90459e&t=\(txt)&type=movie"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("hata meydana geldi")
            }else {
                if let response = response as? HTTPURLResponse {
                    print("\(response.statusCode)")
                }
                var result : Movie?
                do {
                     result = try JSONDecoder().decode(Movie.self, from: data!)
                    
                } catch {
                    print("error")
                }
                guard let finalResult = result else {return }
                
                let newMovie = finalResult
                self.movies.append(newMovie)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }

}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.idenfier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
    }
}
extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovie()
        return true
    }
}



