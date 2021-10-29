//
//  ViewController.swift
//  Multithreading-GCD
//
//  Created by ruslan on 25.10.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    
    private let queue = DispatchQueue.global(qos: .utility)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadButton.layer.cornerRadius = 15
        activityIndicatorView.isHidden = true
    }
        
    @IBAction func downloadButtonAction(_ sender: UIButton) {
        mainImageView.image = nil
        activityIndicatorView.isHidden = false
        print("start")
        activityIndicatorView.startAnimating()
        queue.async {
            if let data = try? Data(contentsOf: ImageList.list.randomElement()!) {
                DispatchQueue.main.async {
                    self.mainImageView.image = UIImage(data: data)
                    self.activityIndicatorView.isHidden = true
                    print("stop")
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
}

