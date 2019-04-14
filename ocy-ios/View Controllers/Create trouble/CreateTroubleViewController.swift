//
//  CreateTroubleViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit
import MapKit


class CreateTroubleViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var interactor : CreateTroubleInteractor!
    var categories = [Category]()
    var attachImages = [UIImage]()
    
    var categoryPicker : UIPickerView!
    
    @IBOutlet weak var phoneTextField : OCYTextField!
    @IBOutlet weak var titleTextField : OCYTextField!
    @IBOutlet weak var textTextField : OCYTextField!
    @IBOutlet weak var categoryTextField : OCYTextField!
    @IBOutlet weak var addressTextField : OCYTextField!
    @IBOutlet weak var apartmentTextField : OCYTextField!
    @IBOutlet weak var entranceTextField : OCYTextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var attachmentTableView: UITableView!
    @IBOutlet weak var attachmentTableViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var uploadButton: OCYButton!

    
    
    var mapAnnotation : MKPointAnnotation!
    var locationManager : CLLocationManager!
    
    var selectedCoordinates : CLLocationCoordinate2D? = nil
    var selectedCategory : Category? = nil
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor = CreateTroubleInteractor()
        interactor.delegate = self
        
        categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        categoryTextField.inputView = categoryPicker
        
        
        mapView.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.revealTapOnMap(_:)))
        mapView.addGestureRecognizer(tapRecognizer)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        attachmentTableView.delegate = self
        attachmentTableView.dataSource = self
        attachmentTableView.register(UINib(nibName: "AttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AttachmentTableViewCell")
        
        imagePicker.delegate = self
        
        
        phoneTextField.text = UserController.shared.currentUser.phone

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.categoryTextField.showAnimatedGradientSkeleton()
    }
    
    func reloadTableView(){
        attachmentTableView.reloadData()

        UIView.animate(withDuration: 0.3, animations: {
            self.attachmentTableViewHeightContraint.constant = CGFloat(80 * self.attachImages.count)
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryTextField.text = categories[row].title
        self.selectedCategory = categories[row]
    }
    
    @objc func revealTapOnMap(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        
        self.selectedCoordinates = locationCoordinate
        
        //Set pin
        if let annoation = self.mapAnnotation {
            mapView.removeAnnotation(annoation)
        }
        setCoordinate()
    }
    
    func setCoordinate(){
        self.mapAnnotation = MKPointAnnotation()
        self.mapAnnotation.coordinate = self.selectedCoordinates!
        self.mapView.addAnnotation(self.mapAnnotation)
    }
    
    @IBAction func chooseImage(_ sender : OCYButton){
        let alert = UIAlertController(title: "Выберите вариант", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Снять на камеру", style: .default, handler: { _ in
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Выбрать с галереи", style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func createTrouble(_ sender : OCYButton){
        
        var trouble = Trouble()
        trouble.phone = phoneTextField.text ?? ""
        trouble.header = titleTextField.text ?? ""
        trouble.message = textTextField.text ?? ""
        trouble.category = selectedCategory
        trouble.address = addressTextField.text ?? ""
        trouble.room = apartmentTextField.text ?? ""
        trouble.porch = entranceTextField.text ?? ""
        trouble.latitude = String(selectedCoordinates?.latitude ?? 0.0)
        trouble.longitude = String(selectedCoordinates?.longitude ?? 0.0)
        
        interactor.uploadTrouble(trouble)
    }
    
}

extension CreateTroubleViewController : CreateTroubleInteractorDelegate {
    func setCategories(_ categories: [Category]) {
        self.categories = categories
        categoryPicker.reloadAllComponents()
        
        self.categoryTextField.hideSkeleton()
    }
    
    
    func showLoading() {
        self.uploadButton.showAnimatedGradientSkeleton()
    }
    
    func hideLoading() {
        self.uploadButton.hideSkeleton()
    }
}

extension CreateTroubleViewController : MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            mapView.camera.centerCoordinate = location.coordinate
            mapView.camera.altitude = 2000.0
            mapView.showsUserLocation = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        self.alert(error.localizedDescription)
        
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
    }
    
}

extension CreateTroubleViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attachImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentTableViewCell") as! AttachmentTableViewCell
        
        cell.attachImageView.image = attachImages[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Убрать фото?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Убрать", style: .destructive, handler: { _ in
            self.attachImages.remove(at: indexPath.row)
            self.reloadTableView()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


extension CreateTroubleViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.attachImages.append(image)
        self.reloadTableView()
    }
    
}
