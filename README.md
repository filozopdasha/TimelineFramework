# TimeLineFramework

**TimeLineFramework** is a SwiftUI framework to create interactive horizontal timelines. Each event can display an icon, title, date, and description, with built-in animations and optional like/share functionality.

---

## Features

- Supports important and normal events with different circle sizes
- Fully customizable colors, spacing, and animations
- Three built-in animations: `bounce`, `jump`, and `fade`
- Optional like and share buttons for each event
- Popup view with detailed event description
- Accessibility

---

## Installation

### Swift Package Manager

You can add **TimeLineFramework** to your project using Swift Package Manager in Xcode:

#### Using Xcode UI

1. Open your Xcode project.
2. Go to **File → Swift Packages → Add Package Dependency…**
3. Enter the repository URL: "https://github.com/filozopdasha/TimelineFramework"

Once added, simply import it in your Swift files:


## Usage

### 1. Import the Framework

At the top of your SwiftUI file, import the framework:

```
import TimeLineFramework
```

### 2. Create Timeline Events

Define an array of `TimelineEvent` objects. Each event can have:

- `title`: The name of the event (`String`)
- `date`: The date of the event (`String`)
- `description`: A SwiftUI view describing the event

Optional parameters:

- `color`: The color of the circle (`Color`)
- `isImportant`: `Bool` to indicate a larger circle
- `icon`: Custom icon as `AnyView`

Example:
```
let events: [TimelineEvent] = [
    TimelineEvent(
        isImportant: true,
        color: .blue,
        title: "Founding of the Academy",
        date: "1615",
        description: {
            Text("The Kyiv Brotherhood School was transformed into the ") +
            Text("Kyiv-Mohyla Collegium").bold() +
            Text(", marking the beginning of the Academy's long history of education.")
        },
        icon: {
            AnyView(
                Image(systemName: "building.columns.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 46, height: 46)
            )
        }
    ),
    TimelineEvent(
        isImportant: false,
        color: .green,
        title: "Academy Expansion",
        date: "1701",
        description: {
            Text("The Collegium was officially named Kyiv-Mohyla Academy, expanding its curriculum and influence across Ukraine.")
        }
    )
]
```

### 3. Add TimelineView to Your SwiftUI View

Pass the events array and configure optional parameters:

- `typeOfAnimation`: `.bounce`, `.jump`, or `.fade`
- `visibleCount`: Number of circles visible on screen
- `addedLikes` / `addedShare`: Show like/share buttons

```
TimelineView(
    events: events,
    typeOfAnimation: .jump,
    visibleCount: 3,
    addedLikes: true,
    addedShare: true
)
```

### List of TimelineStyle Properties

`TimelineStyle` allows you to customize the appearance and behavior of your timeline. All properties are optional and have default values.

- **`lineColor`** (`Color`) – The color of the horizontal timeline line.  
  *Default:* `.blue`

- **`importantCircleSize`** (`CGFloat`) – Diameter of circles representing important events.  
  *Default:* `35`

- **`normalCircleSize`** (`CGFloat`) – Diameter of regular event circles.  
  *Default:* `20`

- **`spacing`** (`CGFloat`) – Default spacing between timeline circles. Can be overridden by `visibleCount` logic.  
  *Default:* `50`

- **`dateVerticalOffset`** (`CGFloat`) – Vertical offset for the date label relative to the circle.  
  *Default:* `25`

- **`eventVerticalOffset`** (`CGFloat`) – Vertical offset for the circle itself.  
  *Default:* `-5`

- **`animationSpeed`** (`CGFloat`) – Speed of circle animations (`bounce` / `jump`).  
  *Default:* `0.35`

- **`animationBouncing`** (`CGFloat`) – Damping fraction for bounce/jump animations (controls "springiness").  
  *Default:* `0.75`

- **`popupCornerRadius`** (`CGFloat`) – Corner radius for the popup view that appears on circle tap.  
  *Default:* `25`

- **`popupBackground`** (`Color`) – Background color of the popup view.  
  *Default:* `Color.gray.opacity(0.1)`

- **`popupTitleFont`** (`Font`) – Font style for the popup title.  
  *Default:* `.title.bold()`

- **`popupDescriptionFont`** (`Font`) – Font style for the popup description text.  
  *Default:* `.body`

- **`popupPadding`** (`CGFloat`) – Padding inside the popup view.  
  *Default:* `20`

### License

For licensing information, see [LICENSE](./LICENSE) for details.
