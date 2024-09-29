//
//  Project.stencil.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도형 on 6/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "App",
            destinations: .appDestinations,
            product: .app,
            bundleId: .moduleBundleId(name: "App"),
            deploymentTargets: .appMinimunTarget,
            infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/FAKEandFAITH-info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                // TODO: 의존성 추가
                .project(target: "FeatureMain", path: .relativeToRoot("Projects/Feature")),
                .project(target: "FeatureMainDetail", path: .relativeToRoot("Projects/Feature")),
                .project(target: "FeatureEyeDetail", path: .relativeToRoot("Projects/Feature")),
                .project(target: "FeatureNewsFeed", path: .relativeToRoot("Projects/Feature"))
            ]
        )
    ]
)
