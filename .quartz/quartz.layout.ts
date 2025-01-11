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
