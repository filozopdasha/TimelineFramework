//
//  TimelinePopupView.swift
//  TimeLineFramework
//
//  Created by Dasha Filozop on 10.11.2025.
//

import SwiftUI

struct TimelinePopupView: View {
    let event: TimelineEvent
    let style: TimelineStyle
    @Binding var likedEvents: Set<UUID>
    let addedLikes: Bool
    let addedShare: Bool
    @Binding var shareButtonUsed: Bool
    @Environment(\.dismiss) private var closeButton

    var body: some View {
        VStack(spacing: 20) {
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

            VStack(spacing: 10) {
                event.titleView

                ScrollView {
                    event.descriptionView
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)

                }
                .frame(maxHeight: 220)
            }
            .accessibilityElement(children: .combine)
            .padding(.horizontal)

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
                    .accessibilityLabel(likedEvents.contains(event.id) ? "Liked" : "Tap here to like this event")

                }
            }

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
                    .accessibilityLabel("Tap here to Share the event")

                }
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
