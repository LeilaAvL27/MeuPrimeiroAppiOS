//
//  DetailViewController.swift
//  MeuPrimeiroAppIOS
//
//  Created by user on 05/09/23.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieImageView.layer.cornerRadius = 8
        movieImageView.layer.masksToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.backgroundColor = .green
        

    }
}
