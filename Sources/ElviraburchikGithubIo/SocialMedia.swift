//
//  SocialMedia.swift
//  
//
//  Created by Elvira Burchik on 4/24/20.
//

import Foundation

struct SocialMediaLink {
    let title: String
    let url: String
    let icon: String
}

extension SocialMediaLink {
    
//    static var linkedIn: SocialMediaLink {
//        return SocialMediaLink(
//            title: "LinkedIn",
//            url: "https://www.linkedin.com/in/maciej-kowalski-284165156/",
//            icon: "fa fa-linkedin"
//        )
//    }
//    
//    static var email: SocialMediaLink {
//        return SocialMediaLink(
//            title: "Email",
//            url: "mailto:maciej.mateusz.kowalski@gmail.com",
//            icon: "fa fa-envelope"
//        )
//    }
    
    static var twitter: SocialMediaLink {
        return SocialMediaLink(
            title: "Twitter",
            url: "https://twitter.com/ElviraBurchik",
            icon: "fa fa-twitter.png"
        )
    }
    
}
