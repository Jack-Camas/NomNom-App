//
//  ViewController.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import UIKit

class SplashScreenController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let imageView = UIImageView(image: UIImage(named: "nom_logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view.subviews.forEach { $0.removeFromSuperview() }
            // Present your app's main view controller here
            
            let onboardingVC = OnBoardingController()
            onboardingVC.modalPresentationStyle = .fullScreen
            self.present(onboardingVC, animated: false)
          
           
        }
        
        
        
    }
    
}

