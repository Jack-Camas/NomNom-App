//
//  OnBoardingController.swift
//  nomnom
//
//  Created by Jack on 11//23.
//

import UIKit
import CoreLocation

class OnBoardingController: UIViewController {
    
    let vc = TabBarView()
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private var keyboardHeight: CGFloat = 0
    private let blurEffect = UIBlurEffect(style: .dark)
    private let blurView = UIVisualEffectView()
    var longitud:CLLocationDegrees?
    var latitud:CLLocationDegrees?
    
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "onboarding_img"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let zipCodeText: UITextView = {
        let txt = UITextView()
        txt.text = "Welcome to NomNom, please add your zip code"
        txt.textAlignment = .center
        txt.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        txt.isEditable = false
        return txt
    }()
    
    private let zipCodeTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter your zip code"
        txt.textAlignment = .center
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.red.cgColor
        txt.layer.cornerRadius = 5
        return txt
    }()
    
    private let orText: UITextView = {
        let txt = UITextView()
        txt.text = "or"
        txt.textAlignment = .center
        txt.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        txt.isEditable = false
        return txt
    }()
    
    private let locationBtn: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.red.cgColor
        btn.setTitleColor(.clear, for: .normal)
        btn.backgroundColor = .clear
        btn.setTitle("", for: .normal)
        btn.addTarget(OnBoardingController.self, action: #selector(handleLocationButtonPressed), for: .touchUpInside)
        
        return btn
    }()
    
    private let continueBtn: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.red.cgColor
        btn.setTitleColor(.clear, for: .normal)
        btn.backgroundColor = .clear
        btn.setTitle("Continue", for: .normal)
        btn.addTarget(OnBoardingController.self, action: #selector(onContinueTapped), for: .touchUpInside)
        return btn
    }()
    
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        view.backgroundColor = .white
       
        setupViews()
        setupConstraints()
      
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Add keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Store the original position of the zipCodeTextField
        originalZipCodeTextFieldFrame = zipCodeTextField.frame
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Methods
    
  

    private func setupViews() {
        // Add a new view to cover the entire screen
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = 0
        blurView.effect = blurEffect // Add blur effect
        
        
        view.addSubview(imageView)
        view.addSubview(zipCodeText)
        view.addSubview(orText)
        view.addSubview(locationBtn)
        view.addSubview(continueBtn)
        
        view.addSubview(blurView)
        view.addSubview(zipCodeTextField)
        
        
    }
    
    private var continueBtnBottomConstraint: NSLayoutConstraint?
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        
        // add imageView as subview of view
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        
        
        zipCodeText.translatesAutoresizingMaskIntoConstraints = false
        zipCodeText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zipCodeText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding).isActive = true
        zipCodeText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        zipCodeText.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        zipCodeTextField.topAnchor.constraint(equalTo: zipCodeText.bottomAnchor, constant: padding).isActive = true
        zipCodeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zipCodeTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        zipCodeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        zipCodeTextField.borderStyle = .roundedRect
        
        orText.translatesAutoresizingMaskIntoConstraints = false
        orText.topAnchor.constraint(equalTo: zipCodeTextField.bottomAnchor, constant: padding).isActive = true
        orText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orText.widthAnchor.constraint(equalToConstant: 50).isActive = true
        orText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        locationBtn.translatesAutoresizingMaskIntoConstraints = false
        locationBtn.topAnchor.constraint(equalTo: orText.bottomAnchor, constant: padding).isActive = true
        locationBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationBtn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        locationBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        locationBtn.setTitle("Use Current Location", for: .normal)
        locationBtn.setTitleColor(.red, for: .normal)
        locationBtn.layer.cornerRadius = 5
        
        continueBtn.translatesAutoresizingMaskIntoConstraints = false
        continueBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueBtn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        continueBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        continueBtn.setTitle("Continue", for: .normal)
        continueBtn.setTitleColor(.white, for: .normal)
        continueBtn.backgroundColor = .red
        continueBtn.layer.cornerRadius = 5
        continueBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true
        
        
    }
    
    
    private var originalZipCodeTextFieldFrame: CGRect?
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            originalZipCodeTextFieldFrame = zipCodeTextField.frame
            moveZipCodeTextFieldUp()
            
            // Animate the blur view to appear
            UIView.animate(withDuration: 0.3) {
                self.blurView.alpha = 0.8
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        keyboardHeight = 0
        moveZipCodeTextFieldDown()
        
        // Animate the blur view to disappear
        UIView.animate(withDuration: 0.3) {
            self.blurView.alpha = 0
        }
    }
    
    private func moveZipCodeTextFieldUp() {
        UIView.animate(withDuration: 0.3) {
            self.zipCodeTextField.frame.origin.y = self.view.frame.height - self.keyboardHeight - self.zipCodeTextField.frame.height - 20
        }
    }
    
    private func moveZipCodeTextFieldDown() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                if let originalFrame = self.originalZipCodeTextFieldFrame {
                    self.zipCodeTextField.frame = originalFrame
                } else {
                    self.zipCodeTextField.frame.origin.y = self.view.frame.height - self.zipCodeTextField.frame.height - 20
                }
            }
        }
    }
    
    @objc private func handleLocationButtonPressed() {
        print("hello")
        requestLocationPermission()
    }
    
    @objc private func onContinueTapped() {
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
        
    }
    
    //MARK: - request permission to access the user's device location
    
    private func requestLocationPermission() {
        //locationManager.delegate = self
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // Location permission already granted
            break
        case .notDetermined:
            // Request permission to access location
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Show alert with instructions to enable location permission in settings
            let alert = UIAlertController(title: "Location permission required",
                                          message: "Please enable location permission for this app in Settings.",
                                          preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        @unknown default:
            break
        }
    }
    
    
}


extension OnBoardingController: CLLocationManagerDelegate{
    
   
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Handle changes to location authorization status
        longitud =  manager.location?.coordinate.latitude
        latitud = manager.location?.coordinate.longitude
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            // Location services are enabled and the user has granted permission
            
            self.vc.modalPresentationStyle = .fullScreen
            self.present(self.vc, animated: false)
            
            print("Location services are enabled and the user has granted permission")
        case .denied, .restricted:
            // The user has denied or restricted location services
            print("The user has denied or restricted location services")
        case .notDetermined:
            // The user has not yet made a choice regarding location services
            print("The user has not yet made a choice regarding location services")
        @unknown default:
            fatalError()
        }
    }
}



