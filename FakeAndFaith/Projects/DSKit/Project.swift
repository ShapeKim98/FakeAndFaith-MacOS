//
//  Project.stencil.swift
//  Packages
//
//  Created by 김도형 on 6/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DSKit",
    targets: [
        .target(
            name: "DSKit",
            destinations: .appDestinations,
            // TODO: 프로젝트에 맞는 product로 변경해야 함
            product: .staticFramework,
            bundleId: .moduleBundleId(name: "DSKit"),
            deploymentTargets: .appMinimunTarget,
            infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/FAKEandFAITH-info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                // TODO: 의존성 추가
                .project(target: "Util", path: .relativeToRoot("Projects/Util"))
            ]
        )
    ]
)
