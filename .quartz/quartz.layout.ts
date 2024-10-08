import {PageLayout, SharedLayout} from "./quartz/cfg"
import * as Component from "./quartz/components"

// components shared across all pages
export const sharedPageComponents: SharedLayout = {
    head: Component.Head(),
    header: [],
    afterBody: [
        Component.Backlinks(),
        // Component.SocialShare(),
        Component.Remark({
            options: {
                host: 'https://comments.struchkov.dev',
                siteId: 'gardenru',
                locale: 'ru',
            }
        }),
        Component.YandexMetrika(),
    ],
    footer: Component.Footer({
        links: {
            "About Me": "https://mark.struchkov.dev/cv/",
            "B.log": "https://struchkov.dev",
            "Telegram": "https://t.me/struchkov_dev",
        },
    }),
}
const githubSourceConfig = {
    repoLink: "https://github.com/upagge/digital-garden",
    branch: "master"
}
// components for pages that display a single page (e.g. a single note)
export const defaultContentPageLayout: PageLayout = {
    beforeBody: [
        Component.Breadcrumbs({showCurrentPage: false}),
        Component.ArticleTitle(),
        Component.ContentMeta({showReadingTime: false}),
        Component.TagList()
    ],
    left: [
        Component.PageTitle(),
        Component.MobileOnly(Component.Spacer()),
        Component.Search(),
        Component.DesktopOnly(Component.RecentNotes({ showTags: false, limit: 4 })),
        Component.DesktopOnly(Component.Ads()),
        Component.Darkmode(),
    ],
    right: [
        Component.DesktopOnly(Component.Graph({
            localGraph: {
                drag: true, // whether to allow panning the view around
                zoom: true, // whether to allow zooming in and out
                depth: 1, // how many hops of notes to display
                scale: 2, // default view scale
                repelForce: 0.5, // how much nodes should repel each other
                centerForce: 0.3, // how much force to use when trying to center the nodes
                linkDistance: 30, // how long should the links be by default?
                fontSize: 0.5, // what size should the node labels be?
                opacityScale: 2, // how quickly do we fade out the labels when zooming out?
                removeTags: [], // what tags to remove from the graph
                showTags: false, // whether to show tags in the graph
            },
            globalGraph: {
                drag: true,
                zoom: true,
                depth: -1,
                scale: 2,
                repelForce: 0.5,
                centerForce: 0.3,
                linkDistance: 30,
                fontSize: 0.5,
                opacityScale: 1,
                removeTags: [], // what tags to remove from the graph
                showTags: false, // whether to show tags in the graph
            },
        })),
        Component.DesktopOnly(Component.TableOfContents()),
        Component.DesktopOnly(Component.GithubSource(githubSourceConfig)),
    ],
}

// components for pages that display lists of pages  (e.g. tags or folders)
export const defaultListPageLayout: PageLayout = {
    beforeBody: [Component.Breadcrumbs(), Component.ArticleTitle(), Component.ContentMeta()],
    left: [
        Component.PageTitle(),
        Component.MobileOnly(Component.Spacer()),
        Component.Search(),
        Component.Darkmode(),
    ],
    right: [],
}
