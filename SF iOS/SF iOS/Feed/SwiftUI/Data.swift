//
//  Data.swift
//  Coffup
//
//  Created by Roderic Campbell on 6/8/19.
//

import UIKit
import SwiftUI
import CoreLocation
import Combine

struct WrappedEvent /*, BindableObject*/ {
//    var didChange = (NotificationCenter.default.publisher(for: "eventChange") as AnyObject).receive(on: RunLoop.main)
//    var event: Event
    let name: String
    let eventID: String
    let startDate: String
    let venue: Venue
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: venue.location.latitude,
            longitude: venue.location.longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case eventID = "id"
        case name = "name"
        case venue = "venue"
        case startDate = "start_at"
    }
}

struct Venue: Hashable, Codable {
    let name: String
    let location: Location
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case location = "location"
    }
}

struct Location: Hashable, Codable {
    let address: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case address = "formatted_address"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

extension WrappedEvent: Decodable {
}


let eventData: [WrappedEvent] = load("eventData.json")

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    print("this is good")
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    fileprivate typealias _ImageDictionary = [String: [Int: CGImage]]
    fileprivate var images: _ImageDictionary = [:]
    
    fileprivate static var originalSize = 250
    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String, size: Int) -> Image {
        let index = _guaranteeInitialImage(name: name)
        
        let sizedImage = images.values[index][size]
            ?? _sizeImage(images.values[index][ImageStore.originalSize]!, to: size * ImageStore.scale)
        images.values[index][size] = sizedImage
        
        return Image(sizedImage, scale: Length(ImageStore.scale), label: Text(verbatim: name))
    }
    
    fileprivate func _guaranteeInitialImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
            else {
                fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        
        images[name] = [ImageStore.originalSize: image]
        return images.index(forKey: name)!
    }
    
    fileprivate func _sizeImage(_ image: CGImage, to size: Int) -> CGImage {
        guard
            let colorSpace = image.colorSpace,
            let context = CGContext(
                data: nil,
                width: size, height: size,
                bitsPerComponent: image.bitsPerComponent,
                bytesPerRow: image.bytesPerRow,
                space: colorSpace,
                bitmapInfo: image.bitmapInfo.rawValue)
            else {
                fatalError("Couldn't create graphics context.")
        }
        context.interpolationQuality = .high
        context.draw(image, in: CGRect(x: 0, y: 0, width: size, height: size))
        
        if let sizedImage = context.makeImage() {
            return sizedImage
        } else {
            fatalError("Couldn't resize image.")
        }
    }
}

