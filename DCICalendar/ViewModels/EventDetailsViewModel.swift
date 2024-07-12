//
// EventDetailsViewModel.swift
// DCICalendar
//
// Created by Arnav Bhatt on 7/11/24.
//
import SwiftUI
import MapKit
struct CustomAnnotation: Identifiable {
  let id = UUID()
  let coordinate: CLLocationCoordinate2D
  var title: String?
}
class EventDetailsViewModel: ObservableObject {
  @Published var mapRegion: MKCoordinateRegion
  @Published var annotations: [CustomAnnotation]
  init(address: String) {
    let defaultLocation = CLLocationCoordinate2D(latitude: 35.9915839, longitude: -78.9039173)
    self.mapRegion = MKCoordinateRegion(center: defaultLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    let defaultAnnotation = CustomAnnotation(coordinate: defaultLocation, title: "Event")
    self.annotations = [defaultAnnotation]
    geocodeAddress(address)
  }
  private func geocodeAddress(_ address: String) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
      if let coordinate = placemarks?.first?.location?.coordinate {
        DispatchQueue.main.async {
          self?.mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
      }
    }
  }
}
