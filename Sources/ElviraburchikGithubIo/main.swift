import Foundation
import Publish
import Plot

struct PersonalWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case about
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    var url = URL(string: "https://elviraburchik.github.io")!
    var name = "Elvira Burchik"
    var description = "Hi 👋 I'm Elvira Burchik"
    var language: Language { .english }
    var imagePath: Path? { "images/favicon.png" }
    var favicon: Favicon? { Favicon(path: "/images/favicon.png") }
}

try PersonalWebsite().publish(withTheme: .website,
                              deployedUsing: .gitHub("ElviraBurchik/elviraburchik.github.io", useSSH: false))
