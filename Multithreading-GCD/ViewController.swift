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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadButton.layer.cornerRadius = 15
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
        
    }
}

