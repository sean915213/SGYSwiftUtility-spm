//
//  InfoConfig.swift
//  
//
//  Created by Sean Young on 7/9/22.
//

import Foundation

public struct InfoConfig: Codable {
    
    public enum CodingKeys: String, CodingKey {
        case appVersion = "CFBundleShortVersionString"
        case appBuild = "CFBundleVersion"
    }
    
    public var appVersion: SemanticVersion
    public var appBuild: String
}
