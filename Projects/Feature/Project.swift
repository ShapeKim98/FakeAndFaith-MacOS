//
//  Project.stencil.swift
//  Packages
//
//  Created by 김도형 on 6/16/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let mainTarget: Target = .target(
    name: "FeatureMain",
    destinations: .appDestinations,
    product: .framework,
    bundleId: .moduleBundleId(name: "FeatureMain"),
    deploymentTargets: .appMinimunTarget,
    sources: ["Main/Sources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
        .project(target: "DSKit", path: .relativeToRoot("Projects/DSKit"))
    ])

let mainDemoTarget: Target = .target(
    name: "FeatureMainDemo",
    destinations: .appDestinations,
    product: .app,
    bundleId: .moduleBundleId(name: "FeautreMainDemo"),
    deploymentTargets: .appMinimunTarget,
    infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/FAKEandFAITH-info.plist")),
    sources: ["MainDemo/Sources/**"],
    dependencies: [
        .target(mainTarget)
    ])

let eyeDetailTarget: Target = .target(
    name: "FeatureEyeDetail",
    destinations: .appDestinations,
    product: .framework,
    bundleId: .moduleBundleId(name: "FeatureEyeDetail"),
    deploymentTargets: .appMinimunTarget,
    sources: ["EyeDetail/Sources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
        .project(target: "DSKit", path: .relativeToRoot("Projects/DSKit"))
    ])

let eyeDetailDemoTarget: Target = .target(
    name: "FeatureEyeDetailDemo",
    destinations: .appDestinations,
    product: .app,
    bundleId: .moduleBundleId(name: "FeatureEyeDetailDemo"),
    deploymentTargets: .appMinimunTarget,
    sources: ["EyeDetailDemo/Sources/**"],
    dependencies: [
        .target(eyeDetailTarget)
    ])

let mainDetailTarget: Target = .target(
    name: "FeatureMainDetail",
    destinations: .appDestinations,
    product: .framework,
    bundleId: .moduleBundleId(name: "FeatureMainDetail"),
    deploymentTargets: .appMinimunTarget,
    sources: ["MainDetail/Sources/**"],
    dependencies: [
        .target(eyeDetailTarget),
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
        .project(target: "DSKit", path: .relativeToRoot("Projects/DSKit"))
    ])

let mainDetailDemoTarget: Target = .target(
    name: "FeatureMainDetailDemo",
    destinations: .appDestinations,
    product: .app,
    bundleId: .moduleBundleId(name: "FeatureMainDetailDemo"),
    infoPlist: .file(path: .relativeToRoot("Projects/App/Resources/FAKEandFAITH-info.plist")),
    sources: ["MainDetailDemo/Sources/**"],
    dependencies: [
        .target(mainDetailTarget)
    ])

let project = Project(
    name: "Feature",
    targets: [
        mainTarget,
        mainDemoTarget,
        mainDetailTarget,
        mainDetailDemoTarget,
        eyeDetailTarget,
        eyeDetailDemoTarget
    ]
)
