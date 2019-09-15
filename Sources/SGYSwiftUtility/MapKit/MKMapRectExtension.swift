//
//  MKMapRectExtension.swift
//  
//
//  Created by Sean G Young on 9/15/19.
//

import MapKit

extension MKMapRect {
    
    /// Generates an `MKMapRect` containing `annotations`. Does not guarantee that this region will be totally visible. If `annotations` is empty this will return the null map rect.
    ///
    /// - Parameter annotations: An array of `MKAnnotation` guaranteed to be included in the resulting rect.
    /// - Returns: An `MKMapRect` containing `annotations` or the null map rect if `annotations` is empty.
    static func makeRectContaining(annotations: [MKAnnotation]) -> MKMapRect {
        return makeRectContaining(coordinates: annotations.map { $0.coordinate })
    }
    
    /// Generates an `MKMapRect` containing `annotations` and centered on `center`. Does not guarantee that this region will be totally visible.
    ///
    /// - Parameters:
    ///   - annotations: An array of `MKAnnotation` guaranteed to be included in the resulting rect.
    ///   - center: The center of the resulting rect.
    /// - Returns: An `MKMapRect` containing `annotations` and centered at `center`.
    static func makeRectContaining(annotations: [MKAnnotation], centeredAt center: CLLocationCoordinate2D) -> MKMapRect {
        return makeRectContaining(coordinates: annotations.map { $0.coordinate }, centeredAt: center)
    }
    
    /// Generates an `MKMapRect` containing `coordinates`. Does not guarantee that this region will be totally visible. If `coordinates` is empty this will return the null map rect.
    ///
    /// - Parameter coordinates: An array of `CLLocationCoordinate2D` guaranteed to be included in the resulting rect.
    /// - Returns: An `MKMapRect` containing `coordinates` or the null map rect if `coordinates` is empty.
    static func makeRectContaining(coordinates: [CLLocationCoordinate2D]) -> MKMapRect {
        return makeRectContaining(points: coordinates.map { MKMapPoint($0) })
    }
    
    /// Generates an `MKMapRect` containing `coordinates` and centered on `center`. Does not guarantee that this region will be totally visible.
    ///
    /// - Parameters:
    ///   - coordinates: An array of `CLLocationCoordinate2D` guaranteed to be included in the resulting rect.
    ///   - center: The center of the resulting rect.
    /// - Returns: An `MKMapRect` containing `coordinates` and centered at `center`.
    static func makeRectContaining(coordinates: [CLLocationCoordinate2D], centeredAt center: CLLocationCoordinate2D) -> MKMapRect {
        return makeRectContaining(points: coordinates.map { MKMapPoint($0) }, centeredAt: MKMapPoint(center))
    }
    
    /// Generates an `MKMapRect` containing `points`. Does not guarantee that this region will be totally visible. If `points` is empty this will return the null map rect.
    ///
    /// - Parameter points: An array of `MKMapPoint` guaranteed to be included in the resulting rect.
    /// - Returns: An `MKMapRect` containing `points` or the null map rect if `points` is empty.
    static func makeRectContaining(points: [MKMapPoint]) -> MKMapRect {
        guard !points.isEmpty else { return MKMapRect.null }
        // Get maximum x, y values
        let maxX = points.map({ $0.x }).max()!
        let maxY = points.map({ $0.y }).max()!
        // Get minimum x, y values
        let minX = points.map({ $0.x }).min()!
        let minY = points.map({ $0.y }).min()!
        // Make rect w/ center in middle of points
        return MKMapRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
    
    /// Generates an `MKMapRect` containing `points` and centered on `center`. Does not guarantee that this region will be totally visible.
    ///
    /// - Parameters:
    ///   - points: An array of `MKMapPoint` guaranteed to be included in the resulting rect.
    ///   - center: The center of the resulting rect.
    /// - Returns: An `MKMapRect` containing `points` and centered at `center`.
    static func makeRectContaining(points: [MKMapPoint], centeredAt center: MKMapPoint) -> MKMapRect {
        guard !points.isEmpty else { return MKMapRect(origin: center, size: MKMapSize(width: 0, height: 0)) }
        // Get maximum x-axis and y-axis distance from center in map points
        let maxX = points.map({ abs($0.x - center.x) }).max()!
        let maxY = points.map({ abs($0.y - center.y) }).max()!
        // Create real map origin as bottom left of rect
        let originPoint = MKMapPoint(x: center.x - maxX, y: center.y - maxY)
        // Make map rect extending maximum distance from origin in all directions from center
        return MKMapRect(origin: originPoint, size: MKMapSize(width: maxX * 2, height: maxY * 2))
    }
}
