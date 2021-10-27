//
//  ViewController.swift
//  Multithreading-GCD
//
//  Created by ruslan on 25.10.2021.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var gearImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    
    private let queue = DispatchQueue.global(qos: .utility)
    
    private let imageURL = URL(string: "https://images.unsplash.com/photo-1635156219587-879ded59e273?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2742&q=80")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadButton.layer.cornerRadius = 15
        gearImageView.isHidden = true
        animateGear()
    }
    
    private func animateGear() {
        guard let image = UIImage(systemName: "gearshape") else { return }
        gearImageView.image = image
        gearImageView.tintColor = .gray
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveLinear, .repeat]) {
            self.gearImageView.transform = CGAffineTransform(rotationAngle: -(3 * .pi) / 2)
        }
    }
        
    @IBAction func downloadButtonAction(_ sender: UIButton) {
        gearImageView.isHidden = false
        mainImageView.image = nil
        queue.async {
            if let data = try? Data(contentsOf: self.imageURL) {
                DispatchQueue.main.async {
                    self.mainImageView.image = UIImage(data: data)
                    self.gearImageView.isHidden = true
                }
            }
        }
    }
}

