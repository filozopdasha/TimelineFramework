//
//  TimelineEvent.swift
//  TimeLineFramework
//
//  Created by Dasha Filozop on 10.11.2025.
//

import SwiftUI

public struct TimelineEvent: Identifiable {
    public let id = UUID()
    public let isImportant: Bool
    public let color: Color
    public let title: String
    public let titleColor: Color?
    public let date: String
    private let descriptionBuilder: () -> AnyView
    private let iconBuilder: (() -> AnyView)?
    public init<DescriptionContent: View>(
        isImportant: Bool = false,
        color: Color = .blue,
        title: String,
        titleColor: Color? = nil,
        date: String,
        @ViewBuilder description: @escaping () -> DescriptionContent,
        icon: (() -> AnyView)? = nil
    ) {
        self.isImportant = isImportant
        self.color = color
        self.title = title
        self.titleColor = titleColor
        self.date = date
        self.descriptionBuilder = {
            AnyView(description())
        }
        if let icon = icon {
            self.iconBuilder = {
                AnyView(icon())
            }
        } else {
            self.iconBuilder = nil
        }    }
    public var titleView: some View {
        Text(title)
            .font(.title)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .foregroundColor(titleColor ?? color)
    }
    public var dateView: some View { Text(date) }
    public var descriptionView: some View { descriptionBuilder() }
    public var copiedText: String { "\(title) - \(date)" }
    public var iconView: some View {
        Group {
            if let iconBuilder = iconBuilder {
                iconBuilder()
                    .foregroundColor(color)
            } else {
                Circle()
                    .fill(color)
                    .frame(width: isImportant ? 35 : 20,
                           height: isImportant ? 35 : 20)
            }
        }
    }
}
