//
//  InfoConfig.swift
//  
//
//  Created by Sean Young on 7/9/22.
//

import Foundation

struct InfoConfig: Codable {
    
    enum CodingKeys: String, CodingKey {
        case appVersion = "CFBundleShortVersionString"
        case appBuild = "CFBundleVersion"
    }
    
    var appVersion: SemanticVersion
    var appBuild: String
}
