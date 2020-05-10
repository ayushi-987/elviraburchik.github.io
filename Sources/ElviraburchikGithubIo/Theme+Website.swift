import Foundation
import Publish
import Plot
import Ink

public extension Theme {
    static var website: Self {
        Theme(
            htmlFactory: WebsiteHTMLFactory(),
            resourcePaths: ["Resources/FoundationTheme/styles.css"]
        )
    }
    
    private struct WebsiteHTMLFactory<Site: Website>: HTMLFactory {
        func makeIndexHTML(for index: Index,
                           context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: index, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .h1(
                            .class("description")
//                            .text(context.site.description)
                        ),
                        .div(
                            .class("flex-container"),
                            .div(
                                .contentBody(index.body)
                            ),
                            .img(.class("avatar"), .src("images/photo.png"))
                        )
                        /*
                         Uncomment when posts will appear
                        .h2("Latest content"),
                        .itemList(
                            for: context.allItems(sortedBy: \.date, order: .descending),
                            on: context.site
                        )
                        */
                    ),
                    .footer(for: context.site)
                )
            )
        }

        func makeSectionHTML(for section: Section<Site>,
                             context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .wrapper(
                        .if(section.title == "about",
                            .div(
                                .div(
                                    .class("flex-container"),
                                    .div(.raw(markdownText(at: "Content/about/flo.md", context: context))),
                                    .img(.class("about-image-vertical"), .src("../images/flo.png"))
                                ),
                                .br(), .br(), .br(),
                                .div(
                                    .class("flex-container"),
                                    .div(.raw(markdownText(at: "Content/about/mo.md", context: context))),
                                    .img(.class("about-image-horizontal"), .src("../images/mo_conf_2019.png"))
                                ),
                                .br(), .br(),
                                .div(
                                    .class("flex-container"),
                                    .raw(markdownText(at: "Content/about/meetups.md", context: context)),
                                    .img(.class("about-image-horizontal"), .src("../images/flo_meetup.png"))
                                ),
                                .br(), .br(), .br(),
                                .div(
                                    .class("flex-container"),
                                    .div(.raw(markdownText(at: "Content/about/talks.md", context: context))),
                                    .img(.class("about-image-horizontal"), .src("../images/talk.png"))
                                )
                            ),
                            else: .itemList(for: section.items, on: context.site)
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }
        
        private func markdownText(at path: String, context: PublishingContext<Site>) -> String {
            let emptyString = ""
            do {
                let path = Path(path)
                let file = try context.file(at: path)
                
                do {
                    let content = try file.read()
                    let parser = MarkdownParser()
                    let string = String(data: content, encoding: .utf8)!
                    let html = parser.html(from: string)
                    return html
                }
                catch { return emptyString }
            } catch {
                return emptyString
            }
        }

        func makeItemHTML(for item: Item<Site>,
                          context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: item, on: context.site),
                .body(
                    .class("item-page"),
                    .header(for: context, selectedSection: item.sectionID),
                    .wrapper(
                        .article(
                            .div(
                                .class("content"),
                                .contentBody(item.body)
                            ),
                            .span("Tagged with: "),
                            .tagList(for: item, on: context.site)
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }

        func makePageHTML(for page: Page,
                          context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(.contentBody(page.body)),
                    .footer(for: context.site)
                )
            )
        }

        func makeTagListHTML(for page: TagListPage,
                             context: PublishingContext<Site>) throws -> HTML? {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .h1("Browse all tags"),
                        .ul(
                            .class("all-tags"),
                            .forEach(page.tags.sorted()) { tag in
                                .li(
                                    .class("tag"),
                                    .a(
                                        .href(context.site.path(for: tag)),
                                        .text(tag.string)
                                    )
                                )
                            }
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }

        func makeTagDetailsHTML(for page: TagDetailsPage,
                                context: PublishingContext<Site>) throws -> HTML? {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .h1(
                            "Tagged with ",
                            .span(.class("tag"), .text(page.tag.string))
                        ),
                        .a(
                            .class("browse-all"),
                            .text("Browse all tags"),
                            .href(context.site.tagListPath)
                        ),
                        .itemList(
                            for: context.items(
                                taggedWith: page.tag,
                                sortedBy: \.date,
                                order: .descending
                            ),
                            on: context.site
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(
                            .li(.a(
                                .href("/"),
                                .text("home")
                            )),
                            .forEach(sectionIDs) { section in
                                .li(.a(
                                    .class(section == selectedSection ? "selected" : ""),
                                    .href(context.sections[section].path),
                                    .text(context.sections[section].title)
                            ))
                        })
                    )
                )
            )
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            ))
        )
    }
}

