//
//  TimeLineView.swift
//  TimeLineFramework
//
//  Created by Dasha Filozop on 10.11.2025.
//

import SwiftUI

public struct TimelineView: View {
    @State private var likedEvents: Set<UUID> = []
    @State private var circleScales: [UUID: CGFloat] = [:]
    @State private var circleOpacities: [UUID: Double] = [:]
    @State private var circleOffsets: [UUID: CGFloat] = [:]
    public var events: [TimelineEvent]
    public var style: TimelineStyle
    public var typeOfAnimation: TimelineTypeOfAnimation?
    public var visibleCount: Int?
    public var addedLikes: Bool = false
    public var addedShare: Bool = false
    @State private var currEvent: TimelineEvent?
    @State private var shareButtonUsed: Bool = false

    public init(
        events: [TimelineEvent],
        style: TimelineStyle = TimelineStyle(),
        typeOfAnimation: TimelineTypeOfAnimation? = nil,
        visibleCount: Int? = nil,
        addedLikes: Bool = false,
        addedShare: Bool = false
    ) {
        self.events = events
        self.style = style
        self.typeOfAnimation = typeOfAnimation
        self.visibleCount = visibleCount
        self.addedLikes = addedLikes
        self.addedShare = addedShare
    }

    public var body: some View {
        VStack(spacing: 30) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: calculatingSpace()) {
                    ForEach(events) { event in
                        EventCircleView(
                            event: event,
                            likedEvents: $likedEvents,
                            circleScales: $circleScales,
                            circleOpacities: $circleOpacities,
                            circleOffsets: $circleOffsets,
                            style: style,
                            typeOfAnimation: typeOfAnimation,
                            currEvent: $currEvent
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
            }
            .overlay(
                Rectangle()
                    .frame(height: 3)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(style.lineColor)
                    .offset(y: 10),
                alignment: .center
            )
        }
        .sheet(item: $currEvent) { event in
            TimelinePopupView(
                event: event,
                style: style,
                likedEvents: $likedEvents,
                addedLikes: addedLikes,
                addedShare: addedShare,
                shareButtonUsed: $shareButtonUsed
            )
        }
    }

    private func calculatingSpace() -> CGFloat {
        guard let visibleCount = visibleCount, !events.isEmpty else {
            return style.spacing
        }

    #if canImport(UIKit)
        let screenWidth = UIScreen.main.bounds.width
    #else
        let screenWidth: CGFloat = 400
    #endif

        var maxCircleWidth: CGFloat = style.normalCircleSize
        let limitedEvents = Array(events.prefix(visibleCount))
        for event in limitedEvents {
            var circleWidth: CGFloat
            if event.isImportant {
                circleWidth = style.importantCircleSize
            } else {
                circleWidth = style.normalCircleSize
            }
            if circleWidth > maxCircleWidth {
                maxCircleWidth = circleWidth
            }
        }
        let totalCircleWidth = CGFloat(limitedEvents.count) * maxCircleWidth
        let leftSpace = max(screenWidth - totalCircleWidth, 0)
        let spaceBetweenCircles = leftSpace / CGFloat(limitedEvents.count)
        return spaceBetweenCircles
    }
}

public enum TimelineTypeOfAnimation {
    case bounce
    case jump
    case fade
}
#if canImport(UIKit)

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
#endif

struct EventCircleView: View {
    let event: TimelineEvent
    @Binding var likedEvents: Set<UUID>
    @Binding var circleScales: [UUID: CGFloat]
    @Binding var circleOpacities: [UUID: Double]
    @Binding var circleOffsets: [UUID: CGFloat]

    let style: TimelineStyle
    let typeOfAnimation: TimelineTypeOfAnimation?
    @Binding var currEvent: TimelineEvent?

    var body: some View {
        VStack(spacing: 0) {
            Button {
                animationsCreator(event: event)
            } label: {
                ZStack(alignment: .topTrailing) {
                    event.iconView
                        .scaleEffect(circleScales[event.id] ?? 1.0)
                        .opacity(circleOpacities[event.id] ?? 1.0)
                        .offset(y: circleOffsets[event.id] ?? 0)

                    if likedEvents.contains(event.id) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 10, weight: .bold))
                            .offset(x: 6, y: -6)
                    }
                }
            }
            .offset(y: style.eventVerticalOffset)
            event.dateView
                .padding(.top, style.dateVerticalOffset)
        }
    }

    private func animationsCreator(event: TimelineEvent) {
        guard let type = typeOfAnimation else {
            currEvent = event
            return
        }

        if type == .bounce {
            withAnimation(.spring(response: style.animationSpeed, dampingFraction: style.animationBouncing)) {
                circleScales[event.id] = 1.3
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    circleScales[event.id] = 1.0
                    currEvent = event
                }
            }

        } else if type == .jump {
            withAnimation(.spring(response: style.animationSpeed, dampingFraction: style.animationBouncing)) {
                circleOffsets[event.id] = -15
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    circleOffsets[event.id] = 0
                    currEvent = event
                }
            }

        } else if type == .fade {
            withAnimation(.easeIn(duration: 0.2)) {
                circleOpacities[event.id] = 0.3
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    circleOpacities[event.id] = 1.0
                    currEvent = event
                }
            }
        }
    }
}
