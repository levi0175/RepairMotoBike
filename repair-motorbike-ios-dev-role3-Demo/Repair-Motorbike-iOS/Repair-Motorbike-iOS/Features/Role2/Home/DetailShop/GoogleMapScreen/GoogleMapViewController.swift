//
//  GoogleMapViewController.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 04/05/2022.
//

import UIKit
import GoogleMaps
class GoogleMapViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var naviBar: UINavigationBarWithBackButton!
    @IBOutlet private weak var openGoogleMaps: UIButton!
    @IBOutlet private weak var myMap: GMSMapView!
    // MARK: - Variables
    var dataGoogMaps: HomeGarageViewEntity.ListGarage1?
    private let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIGoogleMap()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - Setup UI
extension GoogleMapViewController {
    private func setupUI() {
        setupNavi()
        setupButton()
        setCurrentLocotion()
    }
    private func setupNavi() {
     
        naviBar.configData(title: dataGoogMaps?.name ?? NameConstant.GoogleMaps.gooleMap)
        naviBar.tappedBack {
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.hiddenSave()
    }
    private func setupButton() {
        openGoogleMaps.layer.cornerRadius = 8
      //  openGoogleMaps.setBorder(color: .lightGray.withAlphaComponent(0.5), width: 0.2)
    }
    
}
// MARK: - Handle Action
extension GoogleMapViewController {
    func getLatide(data: HomeViewEntity.ListShop) -> Double {
        Double(data.locationX) ?? 0.0
    }
    // 20.647_435, 106.435_743
    @IBAction func openGoogleMapApp(_ sender: Any) {
        let latitudeGoogleMap: Double = 20.647_435
        let longitudeGoogleMap: Double = 106.435_743
            if UIApplication.shared.canOpenURL(NSURL(string: NameConstant.GoogleMaps.stringURL)! as URL) {
                if let url = DetailGaraAPI.share.apiGoogleMaps(lat: latitudeGoogleMap, long: longitudeGoogleMap) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else {
                if UIApplication.shared.canOpenURL(NSURL(string: "maps://")! as URL) {
                        let url = URL(string: "maps://?q=Shop&ll=\(latitudeGoogleMap),\(longitudeGoogleMap)")!
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                    }
                } else {
                    if let destinationURL = DetailGaraAPI.share.apiComGoogle(lat: latitudeGoogleMap, long: longitudeGoogleMap) {
                        UIApplication.shared.open(destinationURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
}

// MARK: - Setup GoogleMap
extension GoogleMapViewController: CLLocationManagerDelegate {
    func setUIGoogleMap() {
        
        locationManager.delegate = self
        let latitudeGoogleMap: Double = 20.647_435
        let longitudeGoogleMap: Double = 106.435_743
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        myMap.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: latitudeGoogleMap, longitude: longitudeGoogleMap), zoom: 0, bearing: 0, viewingAngle: 0.0)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitudeGoogleMap, longitude: longitudeGoogleMap)
        marker.title = dataGoogMaps?.name
        marker.snippet = dataGoogMaps?.address
        marker.map = myMap
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitudeGoogleMap: Double = 20.647_435
        let longitudeGoogleMap: Double = 106.435_743
        myMap.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: latitudeGoogleMap, longitude: longitudeGoogleMap), zoom: 0, bearing: 0, viewingAngle: 0.0)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitudeGoogleMap, longitude: longitudeGoogleMap)
        marker.title = dataGoogMaps?.name
        marker.snippet = dataGoogMaps?.address
        marker.map = myMap
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedAlways:
                return
            case .authorizedWhenInUse:
                return
            case  .denied:
                return
            case .restricted:
                locationManager.requestWhenInUseAuthorization()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func setCurrentLocotion() {
        myMap.settings.myLocationButton = true
        myMap.isMyLocationEnabled = true
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}
