//
//  MapView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI
import MapKit
import SwiftyJSON

struct MapView: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Folio.entity(), sortDescriptors: [], predicate: NSPredicate(format: "removed == false")) var folios: FetchedResults<Folio>
    
    @FetchRequest(entity: Folio.entity(), sortDescriptors: [], predicate: NSPredicate(format: "removed == false")) var folios: FetchedResults<Folio>
    
    @ObservedObject var api = PeopleAPI()
    
    var focus: FetchedResults<Folio>.Element!
    
    //Get map focus on reagion based on focused Folio user or none, default is Oslo.
    private var region: Binding<MKCoordinateRegion> {
        var latitude = 59.9139
        var longitude = 10.7522
        
        return Binding(
            get: {
                if let person = focus {
                    latitude = person.latitude
                    longitude = person.longitude
                }
                
                return MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                    span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                )
            },
        
            set: {_ in}
        )
    }
    
    //Get annotations based on focused on a single folio user or all 100 folio users
    private var annotations: [PersonLocation]? {
        get {
            
            if let person = focus {
                return [PersonLocation(
                    name: "\(person.firstName) \(person.lastName)",
                    thumbnail: person.pictureThumbnail,
                    person: person,
                    coordinates: CLLocationCoordinate2D(
                        latitude: person.latitude,
                        longitude: person.longitude
                    )
                )]
            }
            
            return folios.map({(person) -> PersonLocation in
                return PersonLocation(
                    name: "\(person.firstName) \(person.lastName)",
                    thumbnail: person.pictureThumbnail,
                    person: person,
                    coordinates: CLLocationCoordinate2D(
                        latitude: person.latitude,
                        longitude: person.longitude
                    )
                )
            })
        }
    }
    
    var body: some View {
        NavigationView {
            if let annotations = annotations {
                Map(
                    coordinateRegion: region,
                    annotationItems: annotations,
                    annotationContent: { marker in
                        MapAnnotation(coordinate: marker.coordinates) {
                                if (focus != nil) {
                                    DetailedPersonMarker(marker: marker)
                                } else {
                                    PersonMarker(marker: marker)
                                }
                        }
                    }
                ).navigationBarHidden(true)
                .edgesIgnoringSafeArea([.top])
            }
        }
    }
}

struct PersonLocation: Identifiable {
    let id = UUID()
    let name: String
    let thumbnail: String
    let person: FetchedResults<Folio>.Element!
    let coordinates: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
