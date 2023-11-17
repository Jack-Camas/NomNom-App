//
//  ExpandFeature.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import UIKit
import CoreLocation
import MapKit

class ExpandFeatureController: UIViewController {
    
    var card:BusinessCardModel? = nil
    var quantity = 1
    var heart = "heart.fill"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground

        setConstaints()
    }
    
  
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.load(urlString: card?.urlImage ?? "person")
        return imageView
    }()
    
    private lazy var mealTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.text = card?.name
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        for _ in 1...5 {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.tintColor = .yellow
            stackView.addArrangedSubview(starImageView)
        }
        
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = "Description"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mealDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = card?.addessString
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Quantity "
        return label
    }()
    
    private lazy var quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = Double(quantity)
        stepper.addTarget(self, action: #selector(quantityStepperDidChange), for: .valueChanged)
        return stepper
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Price "
        return label
    }()
    
    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "$\(quantity + 1).00"
        return label
    }()
    
    private lazy var navigateBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Navigate", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(navigationBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    @objc func quantityStepperDidChange() {
        print("we are on quantity steeper did change")
    }
    
    @objc func navigationBtnTapped() {
        // Check if the card object has a valid address
        guard let address = card?.addessString, !address.isEmpty else {
            print("Invalid address")
            return
        }
        
        // Encode the address string for use in a URL
        guard let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Failed to encode address")
            return
        }

        // Construct the URL for opening Google Maps with the navigation intent
        let googleMapsUrlString = "comgooglemaps://?q=\(encodedAddress)&directionsmode=driving"
        guard let googleMapsUrl = URL(string: googleMapsUrlString) else {
            print("Failed to construct Google Maps URL")
            return
        }

        // Check if Google Maps is installed on the device
        if UIApplication.shared.canOpenURL(googleMapsUrl) {
            // Open Google Maps with the navigation intent
            UIApplication.shared.open(googleMapsUrl, options: [:], completionHandler: nil)
        } else {
            // Use Apple Maps as an alternative
            guard let addressString = card?.addessString else {
                print("Invalid address")
                return
            }
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressString) { placemarks, error in
                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                    return
                }
                guard let placemark = placemarks?.first else {
                    print("No placemarks found")
                    return
                }
                let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                mapItem.name = addressString
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
            }
        }
    }





    
    @objc func heartButtonTapped() {
        isHeartFilled.toggle()
    }
    
    private var isHeartFilled = false {
        didSet {
            let imageName = isHeartFilled ? "heart.fill" : "heart"
            heartButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
}


extension  ExpandFeatureController{
    
    
    func setConstaints() {
        // Add the subviews to the scroll view
        scrollView.addSubview(mealImageView)
        scrollView.addSubview(mealTitleLabel)
        scrollView.addSubview(ratingStackView)
        scrollView.addSubview(heartButton)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(mealDescriptionLabel)
        scrollView.addSubview(quantityLabel)
        scrollView.addSubview(quantityStepper)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(priceValueLabel)
        scrollView.addSubview(navigateBtn)
        
        // Add the scroll view to the main view
        view.addSubview(scrollView)
        
        // Enable auto layout for all the views
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        mealDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        navigateBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up the constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Set up the constraints for the meal image view
        NSLayoutConstraint.activate([
            mealImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mealImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mealImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mealImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        // Set up the constraints for the meal title label
        NSLayoutConstraint.activate([
            mealTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mealTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mealTitleLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 16),
        ])
        
        // Set up the constraints for the rating stack view
        NSLayoutConstraint.activate([
            ratingStackView.leadingAnchor.constraint(equalTo: mealTitleLabel.leadingAnchor),
            ratingStackView.topAnchor.constraint(equalTo: mealTitleLabel.bottomAnchor, constant: 8),
        ])
        // Set up the constraints for the rating stack view
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -8),
            heartButton.centerYAnchor.constraint(equalTo: ratingStackView.centerYAnchor),
        ])
        
        // Set up the constraints for the description label
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: mealTitleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 16),
        ])
        
        // Set up the constraints for the meal description label
        NSLayoutConstraint.activate([
            mealDescriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            mealDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mealDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
        ])
        
        // Set up the constraints for the quantity label
        NSLayoutConstraint.activate([
            quantityLabel.leadingAnchor.constraint(equalTo: mealTitleLabel.leadingAnchor),
            quantityLabel.topAnchor.constraint(equalTo: mealDescriptionLabel.bottomAnchor, constant: 16),
            quantityLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
        
        // Set up the constraints for the quantity stepper
        NSLayoutConstraint.activate([
            quantityStepper.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 8),
            quantityStepper.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
        ])
        
        // Set up the constraints for the price label
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: quantityStepper.trailingAnchor, constant: 16),
            priceLabel.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
        ])
        
        // Set up the constraints for the price value label
        NSLayoutConstraint.activate([
            priceValueLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8), priceValueLabel.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor),
        ])
        
        
        
        NSLayoutConstraint.activate([
            navigateBtn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            navigateBtn.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            navigateBtn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            navigateBtn.topAnchor.constraint(equalTo: priceValueLabel.bottomAnchor, constant: 16),
        ])
    }
}
