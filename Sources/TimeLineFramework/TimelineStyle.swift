//
//  TimelineStyle.swift
//  TimeLineFramework
//
//  Created by Dasha Filozop on 10.11.2025.
//
///  Defines visual and animation styling for TimelineView.
///  Allows full customization of layout, sizes, fonts and popup appearance.
///

import SwiftUI

public struct TimelineStyle {
    /// Color of the timeline line
    public var lineColor: Color
    /// size of important event circle
    public var importantCircleSize: CGFloat
    /// Size of normal event circle
    public var normalCircleSize: CGFloat
    /// Spacing between timeline events
    public var spacing: CGFloat
    /// Vertical offset for date label
    public var dateVerticalOffset: CGFloat
    /// Vertical offset for event content
    public var eventVerticalOffset: CGFloat
    /// Animation speed (spring response)
    public var animationSpeed: CGFloat
    /// Animation bounciness (spring damping)
    public var animationBouncing: CGFloat
    /// Corner radius of popup view
    public var popupCornerRadius: CGFloat
    /// Background color of popup
    public var popupBackground: Color
    /// Font for popup title
    public var popupTitleFont: Font
    /// Font for popup description
    public var popupDescriptionFont: Font
    /// Padding of popup
    public var popupPadding: CGFloat

    /// Default style configuration
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
