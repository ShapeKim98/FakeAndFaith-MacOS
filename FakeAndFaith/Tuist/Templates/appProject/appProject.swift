//
//  appProject.swift
//  ProjectDescriptionHelpers
//
//  Created by 김도형 on 6/16/24.
//

import ProjectDescription

let appProjectTemplate = Template(
    description: "Project template",
    items: [
        .file(
            path: "Projects/App/Project.swift",
            templatePath: "Project.stencil"
        ),
        .file(
            path: "Projects/App/Sources/FakeAndFaith.swift",
            templatePath: "App.stencil"),
        .file(
            path: "Projects/App/Resources/FAKEandFAITH-info.plist",
            templatePath: "InfoPlist.stencil"),
    ]
)
