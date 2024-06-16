//
//  Project.stencil.swift
//  Packages
//
//  Created by 김도형 on 6/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: .appDestinations,
            // TODO: 프로젝트에 맞는 product로 변경해야 함
            product: .staticLibrary,
            bundleId: .moduleBundleId(name: "Domain"),
            deploymentTargets: .appMinimunTarget,
            infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/FAKEandFAITH-info.plist")),
            sources: ["Sources/**"],
            dependencies: [
                // TODO: 의존성 추가
                .project(target: "CoreKit", path: .relativeToRoot("Projects/CoreKit"))
            ]
        )
    ]
)