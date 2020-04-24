import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct ElviraburchikGithubIo: Website {
    enum SectionID: String, WebsiteSectionID {
        case about
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "Elvira Burchik"
    var description = "Hi 👋 I'm Elvira Burchik"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
//try ElviraburchikGithubIo().publish(withTheme: .foundation)

try ElviraburchikGithubIo().publish(withTheme: .website,
                                    deployedUsing: .gitHub("ElviraBurchik/elviraburchik.github.io", useSSH: false)
)

//try ElviraburchikGithubIo().publish(using: [
//    .addDefaultSectionTitles(),
//    .deploy(using: .gitHub("ElviraBurchik/elviraburchik.github.io", useSSH: false))
//])

extension PublishingStep where Site == ElviraburchikGithubIo {
    static func addDefaultSectionTitles() -> Self {
        .step(named: "Default section titles") { context in
            context.mutateAllSections { section in
                guard section.title.isEmpty else { return }

                switch section.id {
                case .about:
                    section.title = "About"
                case .posts:
                    section.title = "Posts"
                }
            }
        }
    }
}
