//
//  ViewController.swift
//  RandomUser
//
//  Created by Arlen Peña on 01/08/23.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var personTitle: UILabel!
    @IBOutlet weak var personAbout: UILabel!
    @IBOutlet weak var personEmail: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personAddress: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // Valores por defecto mapa
    private var latitud = 19.2805578
    private var longitud = -99.0609403
    
    private var titleAnnotation = "Current Location"
    private var subtitleAnnotation = "Address"
    
    private let viewModel = PersonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupProfileImg()
        
        viewModel.fetchRandomUser { [self] result in
            switch result {
            case .success(let user):
                if let title = user.name.title,
                   let first = user.name.first,
                   let last = user.name.last {
                    self.personTitle.text = "\(title) \(first) \(last)"
                }
                if let age = user.dob?.age,
                   let city = user.location?.city,
                   let country = user.location?.country{
                    self.personAbout.text = "\(age) años - \(city) - \(country)"
                }
                if let email = user.email{
                    self.personEmail.text = "\(email)"
                }
                if let photo = user.picture?.large{
                    guard let imageURL = URL(string: photo) else {
                        return
                    }
                    
                    UIImage.loadImage(from: imageURL) { [weak self] image in
                        DispatchQueue.main.async {
                            self!.personImage.image = image
                        }
                    }
                }
                if let street = user.location?.street?.name,
                   let number = user.location?.street?.number,
                   let cp = user.location?.postcode,
                   let city = user.location?.city {
                    if cp.intValue != nil {
                        self.personAddress.text = "\(number), \(street), \(cp.intValue ?? 0), \(city)"
                    }else if cp.stringValue != nil {
                        self.personAddress.text = "\(number), \(street), \(cp.stringValue ?? ""), \(city)"
                    }
                    
                }
                if let latitude = user.location?.coordinates?.latitude,
                   let longitude = user.location?.coordinates?.longitude{
                    self.longitud = Double(longitude) ?? 0.0
                    self.latitud = Double(latitude) ?? 0.0
                }
                
                
            case .failure(let error):
                print("Error fetching user: \(error)")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setMapRegion()
        setMapAnnotation()
    }
    
    func setupNavigationBar(){
        self.view.backgroundColor = AppColors.pink
        self.navigationController?.navigationBar.backgroundColor = .clear
        let titleTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupProfileImg(){
        self.personImage.layer.cornerRadius = 115
        self.personImage.contentMode = .scaleAspectFit
        self.personImage.layer.borderColor = AppColors.pink.cgColor
        self.personImage.layer.borderWidth = 4
    }
    
    func setMapRegion(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            let coordinates = CLLocationCoordinate2D(latitude: self.latitud, longitude: self.longitud)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func setMapAnnotation(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitud, longitude: self.longitud)
        annotation.title = self.titleAnnotation
        annotation.subtitle = self.subtitleAnnotation
        self.mapView.addAnnotation(annotation)
    }
    
}

