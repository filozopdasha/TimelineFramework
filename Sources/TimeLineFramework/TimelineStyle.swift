//
//  TimelineStyle.swift
//  TimeLineFramework
//
//  Created by Dasha Filozop on 10.11.2025.
//

import SwiftUI

public struct TimelineStyle {
    public var lineColor: Color
    public var importantCircleSize: CGFloat
    public var normalCircleSize: CGFloat
    public var spacing: CGFloat
    public var dateVerticalOffset: CGFloat
    public var eventVerticalOffset: CGFloat
    public var animationSpeed: CGFloat
    public var animationBouncing: CGFloat
    public var popupCornerRadius: CGFloat
    public var popupBackground: Color
    public var popupTitleFont: Font
    public var popupDescriptionFont: Font
    public var popupPadding: CGFloat

    public init(
        lineColor: Color = .blue,
        importantSize: CGFloat = 35,
        regularSize: CGFloat = 20,
        spacing: CGFloat = 50,
        dateVerticalOffset: CGFloat = 25,
        eventVerticalOffset: CGFloat = -5,
        animationSpeed: CGFloat = 0.35,
        animationBouncing: CGFloat = 0.75,
        popupCornerRadius: CGFloat = 25,
        popupBackground: Color = Color.gray.opacity(0.1),
        popupTitleFont: Font = .title.bold(),
        popupDescriptionFont: Font = .body,
        popupPadding: CGFloat = 20
    ) {
        self.lineColor = lineColor
        self.importantCircleSize = importantSize
        self.normalCircleSize = regularSize
        self.spacing = spacing
        self.dateVerticalOffset = dateVerticalOffset
        self.eventVerticalOffset = eventVerticalOffset
        self.animationSpeed = animationSpeed
        self.animationBouncing = animationBouncing
        self.popupCornerRadius = popupCornerRadius
        self.popupBackground = popupBackground
        self.popupTitleFont = popupTitleFont
        self.popupDescriptionFont = popupDescriptionFont
        self.popupPadding = popupPadding
    }
}
