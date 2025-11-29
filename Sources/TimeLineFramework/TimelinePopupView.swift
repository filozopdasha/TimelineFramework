//
//  TimelinePopupView.swift
//  TimeLineFramework
//
//  Created by Dasha Filozop on 10.11.2025.
//
///  This view represents a popup that displays detailed information
///  about a selected timeline event. It supports optional interaction
///  actions such as liking and sharing, and is fully configurable
///  through TimelineStyle.
///

import SwiftUI

struct TimelinePopupView: View {
    /// Event displayed inside the popup
    let event: TimelineEvent
    /// Style configurations
    let style: TimelineStyle
    /// Ids of liked events
    @Binding var likedEvents: Set<UUID>
    /// Enables Like button
    let addedLikes: Bool
    /// Enables share button
    let addedShare: Bool
    /// Controls share sheet presentation
    @Binding var shareButtonUsed: Bool
    @Environment(\.dismiss) private var closeButton

    var body: some View {
        VStack(spacing: 20) {
            /// Close popup button
            HStack {
                Spacer()
                Button {
                    closeButton()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.secondary)
                        .padding(5)
                        .background(Color(.gray).opacity(0.2))
                        .clipShape(Circle())
                }
                .padding(.trailing)
                .accessibilityLabel("Close popup")
            }

            /// Event title and description
            VStack(spacing: 10) {
                event.titleView
                    .accessibilityAddTraits(.isHeader)

                ScrollView {
                    event.descriptionView
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)
                }
                .frame(maxHeight: 220)
            }
            .padding(.horizontal)

            /// Like button
            if addedLikes {
                Button {
                    if likedEvents.contains(event.id) {
                        likedEvents.remove(event.id)
                    } else {
                        likedEvents.insert(event.id)
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: likedEvents.contains(event.id) ? "heart.fill" : "heart")
                        Text(likedEvents.contains(event.id) ? "Liked" : "Like")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(likedEvents.contains(event.id) ? event.color.opacity(0.2) : Color.gray.opacity(0.2))
                    .foregroundColor(likedEvents.contains(event.id) ? .red : .primary)
                    .cornerRadius(12)
                }
                .accessibilityLabel(likedEvents.contains(event.id) ? "Liked" : "Like this event")
                .accessibilityHint(likedEvents.contains(event.id) ? "Double tap to unlike" : "Double tap to like")
            }

            /// Share button
            if addedShare {
                Button {
                    shareButtonUsed = true
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(12)
                }
                .accessibilityLabel("Share this event")
                .accessibilityHint("Double tap to share")
                .sheet(isPresented: $shareButtonUsed) {
#if canImport(UIKit)
                    ShareSheet(items: [event.copiedText])
#endif
                }
            }

            Spacer()
        }
        .padding(style.popupPadding)
        .background(style.popupBackground)
    }
}
