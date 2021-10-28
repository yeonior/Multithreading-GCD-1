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
    private var animator: UIViewPropertyAnimator!
    private var firstLaunching = true
    
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
        gearImageView.isHidden = true
        animateGear()
    }
    
    private func animateGear() {
        if firstLaunching {
            guard let image = UIImage(systemName: "gearshape") else { return }
            gearImageView.image = image
            gearImageView.tintColor = .gray
//            animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
//                UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat]) {
//                    self.gearImageView.transform = CGAffineTransform(rotationAngle: -(3 * .pi) / 2)
//                }
//            })
            animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2.0,
                                                                      delay: 0.0,
                                                                      options: [.curveLinear,.repeat],
                                                                      animations: {
                                                                        self.gearImageView.transform = CGAffineTransform(rotationAngle: -(3 * .pi) / 2)
                                                                      })
            firstLaunching = false
            print("start")
        }
        animator.startAnimation()
    }
        
    @IBAction func downloadButtonAction(_ sender: UIButton) {
        if !self.firstLaunching {
            print("continue")
            self.animator.startAnimation()
        }
        gearImageView.isHidden = false
        mainImageView.image = nil
        queue.async {
            if let data = try? Data(contentsOf: self.imageURLArray.randomElement()!) {
                DispatchQueue.main.async {
                    self.mainImageView.image = UIImage(data: data)
                    self.gearImageView.isHidden = true
                    print("pause")
                    self.animator.stopAnimation(true)
                }
            }
        }
    }
}

