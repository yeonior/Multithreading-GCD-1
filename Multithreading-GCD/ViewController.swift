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
    
    private let imageURLArray: [URL] = [
        URL(string: "https://images.unsplash.com/photo-1635156219587-879ded59e273?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2742&q=80")!,
        URL(string: "https://images.unsplash.com/photo-1635355995448-77b02d33621d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2670&q=80")!,
        URL(string: "https://images.unsplash.com/photo-1635333607240-1397692acdd2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=927&q=80")!,
        URL(string: "https://images.unsplash.com/photo-1635353779138-0fddba218a30?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1365&q=80")!,
        URL(string: "https://images.unsplash.com/photo-1635331987063-ed4700a9880d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1356&q=80")!,
        URL(string: "https://images.unsplash.com/photo-1635282040419-b4948d5c064c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1323&q=80")!
    ]
    
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
            if let data = try? Data(contentsOf: self.imageURLArray.randomElement()!) {
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

