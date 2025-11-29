//
//  TimelineEvent.swift
//  TimeLineFramework
//
//  Created by Dasha Filozop on 10.11.2025.
//
///  Represents a single event displayed on the timeline.
///  Stores visual data and builders for dynamic SwiftUI content.
///

import SwiftUI

public struct TimelineEvent: Identifiable {
    /// Unique id for the event
    public let id = UUID()
    /// Defines if the event is visually highlighted
    public let isImportant: Bool
    /// Base color used for circle color
    public let color: Color
    /// Main title of the event
    public let title: String
    /// Optional custom title color
    public let titleColor: Color?
    /// Date label displayed under the event
    public let date: String
    /// Builder for description content
    private let descriptionBuilder: () -> AnyView
    /// Optional builder for custom icon
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
        }
    }
    
    /// Styled title view
    public var titleView: some View {
        Text(title)
            .font(.title)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .foregroundColor(titleColor ?? color)
    }
    
    /// Date view
    public var dateView: some View { Text(date) }
    
    /// Description content view
    public var descriptionView: some View { descriptionBuilder() }
    
    /// Text used for sharing
    public var copiedText: String { "\(title) - \(date)" }
    
    /// Customized icon view
    public var iconView: some View {
        Group {
            if let iconBuilder = iconBuilder {
                iconBuilder()
                    .foregroundColor(color)
            } else {
                Circle()
                    .fill(color)
                    .frame(width: isImportant ? 35 : 20, height: isImportant ? 35 : 20)
            }
        }
    }
}

/// A wrapper that automatically handles accessibility for description content
struct DescriptionWrapper<Content: View>: View {
    let content: Content
    @State private var foundText: String?
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .background(
                /// Not visible view that extracts text
                TextFinder(text: $foundText) {
                    content
                }
            )
            .accessibilityLabel(foundText ?? "")
    }
}

/// Helper view that extracts text from Text views
private struct TextFinder<Content: View>: View {
    @Binding var text: String?
    let content: Content
    init(text: Binding<String?>, @ViewBuilder content: () -> Content) {
        self._text = text
        self.content = content()
    }
    
    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .onAppear {
                text = extractPossibleTextField(from: content)
            }
    }
    
    private func extractPossibleTextField(from view: Any) -> String? {
        ///Mirror lets look what's inside of the view
        let mirror = Mirror(reflecting: view)

        /// Check if it's a Text view
        if String(describing: type(of: view)).contains("Text") {
            /// Searching for string content
            for property in mirror.children {
                let innerMirror = Mirror(reflecting: property.value)
                for innerProperty in innerMirror.children {
                    if let foundTextValue = innerProperty.value as? String {
                        return foundTextValue
                    }
                }
            }
        }

        return nil
    }
}
