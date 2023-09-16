import UIKit
import SwiftUI


class RickesViewController: UIViewController {
    private var movies: [Movie] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Terra - 137"
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        addViewsInHierarchy()
        setupConstraints()
        fetchRemoteMovies()
    }
    
    private func addViewsInHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
    }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            ])
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
        
        private func fetchRemoteMovies() {
            let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=2123f7821fc1adc226b8d60b70f445e6&language=pt-BR")!
            
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if error != nil { return }
                
                guard let moviesData = data else { return }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let remoteMovies = try? decoder.decode(TMDBRemoteMovies.self, from: moviesData) else { return }
                
                self.movies = remoteMovies.results
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            task.resume()
        }
    
    
    extension RickesViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = MovieCell()
            let movie = movies[indexPath.row]
            cell.configure(movie: movie)
            return cell
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            movies.count
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Detail", bundle: Bundle(for: DetailViewController.self))
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
            detailViewController.movie = movies[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
            
        }
    }
    

