//
//  App.stencil.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도형 on 6/16/24.
//

import SwiftUI
import FeatureMainDetail
import Domain

@main
struct MainDetailDemoApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: 루트 뷰 추가
            MainDetailView(
                store: .init(initialState: .init(writings: Writing.mock), reducer: {
                    MainDetailFeature()
                }))
        }
    }
}

extension NewsEntity {
    static var mock: [NewsEntity] {
        return [
            .init(content: """
            Faith transcends the boundaries of the tangible world. It allows people to connect with the divine, the eternal, and the infinite. This connection can inspire acts of kindness, compassion, and selflessness, as believers strive to embody the values and virtues of their faith.
            """),
            .init(content: """
            Despite the strong social criticism of pseudo-religion, religious freedom is considered a fundamental right of individuals, so they can also receive legal protection. The constitution of most democracies guarantees an individual's right to freely choose and believe in the desired religion, including pseudo-religion. Thus, restricting or prohibiting pseudo-religion provides room for debate that could violate the freedom of religion stipulated in the constitution.
            """),
            .init(content: """
            Religion can foster a strong sense of belonging and identity. It brings people together, creating communities that support one another through life's joys and challenges. Shared beliefs and practices can provide comfort and consistency, offering a sense of stability in an ever-changing world. Many religious traditions emphasize values such as love, peace, charity, and justice, encouraging adherents to lead lives that contribute positively to society. However, the line between legitimate religious practice and cult-like behavior can sometimes be blurred. Cults often exploit the same human need for belonging and purpose but do so in manipulative and harmful ways. Unlike traditional religions that encourage questioning and personal growth, cults typically demand absolute obedience and discourage critical thinking. They often isolate members from outside influences, creating an environment where dissent is punished, and loyalty to the group is paramount.
            """),
            .init(content: """
            Freedom of religion' is freedom of the inside. Freedom of religion' is an essential freedom of man, which is freedom of the inside, like 'freedom of thought' and 'freedom of thought'. Law does not regulate 'thought', it regulates 'action'. Therefore, no matter how much Korea has freedom of religion, illegal or illegal activities caused by the actions of any religion (organization) cannot be neglected as freedom of religion. Basic legal common sense is necessary to understand this, and it is easy to see that freedom of religion stems from freedom of the inside even with basic common sense.
            """),
            .init(content: """
            Faith transcends the boundaries of the tangible world. It allows people to connect with the divine, the eternal, and the infinite. This connection can inspire acts of kindness, compassion, and selflessness, as believers strive to embody the values and virtues of their faith.
            """),
            .init(content: """
            Despite the strong social criticism of pseudo-religion, religious freedom is considered a fundamental right of individuals, so they can also receive legal protection. The constitution of most democracies guarantees an individual's right to freely choose and believe in the desired religion, including pseudo-religion. Thus, restricting or prohibiting pseudo-religion provides room for debate that could violate the freedom of religion stipulated in the constitution.
            """),
            .init(content: """
            Religion can foster a strong sense of belonging and identity. It brings people together, creating communities that support one another through life's joys and challenges. Shared beliefs and practices can provide comfort and consistency, offering a sense of stability in an ever-changing world. Many religious traditions emphasize values such as love, peace, charity, and justice, encouraging adherents to lead lives that contribute positively to society. However, the line between legitimate religious practice and cult-like behavior can sometimes be blurred. Cults often exploit the same human need for belonging and purpose but do so in manipulative and harmful ways. Unlike traditional religions that encourage questioning and personal growth, cults typically demand absolute obedience and discourage critical thinking. They often isolate members from outside influences, creating an environment where dissent is punished, and loyalty to the group is paramount.
            """),
            .init(content: """
            Freedom of religion' is freedom of the inside. Freedom of religion' is an essential freedom of man, which is freedom of the inside, like 'freedom of thought' and 'freedom of thought'. Law does not regulate 'thought', it regulates 'action'. Therefore, no matter how much Korea has freedom of religion, illegal or illegal activities caused by the actions of any religion (organization) cannot be neglected as freedom of religion. Basic legal common sense is necessary to understand this, and it is easy to see that freedom of religion stems from freedom of the inside even with basic common sense.
            """)
        ]
    }
}
