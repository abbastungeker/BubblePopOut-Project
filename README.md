# BubblePopOut

BubblePopOut is an individual university project I completed during my studies at the University of Technology Sydney.

It is an iOS bubble-popping game developed in Swift using UIKit and storyboards. The player must pop as many bubbles as possible before the timer reaches zero, with different bubble colours awarding different point values.

## Features

- Timed bubble-popping gameplay
- Randomly generated bubble colours and positions
- Different score values based on bubble colour
- Bonus multiplier for consecutive bubbles of the same colour
- Adjustable game duration
- Adjustable maximum number of bubbles
- Player-name input
- Local high-score storage
- Leaderboard sorted from highest to lowest score

## Technologies

- Swift
- UIKit
- Xcode
- Storyboards
- UserDefaults

## How to Run

1. Clone or download the repository.
2. Open `BubblePopOut.xcodeproj` in Xcode.
3. Select an available iPhone simulator.
4. Press **Run** or use `Command + R`.

## How to Play

1. Enter a player name.
2. Adjust the game time and maximum number of bubbles if required.
3. Start the game.
4. Tap the bubbles before they disappear.
5. Try to achieve the highest score before the timer reaches zero.

## Bubble Scores

| Bubble Colour | Points |
|---|---:|
| Red | 1 |
| Pink | 2 |
| Green | 5 |
| Blue | 8 |
| Black | 10 |

Popping consecutive bubbles of the same colour applies a score multiplier.

## Project Structure

- `AppDelegate.swift` — application lifecycle configuration
- `SceneDelegate.swift` — scene lifecycle configuration
- `Bubble.swift` — bubble appearance and scoring properties
- `GameHelper.swift` — shared game settings and score handling
- `HomeViewController.swift` — player-name entry and navigation
- `SettingViewController.swift` — game-time and bubble-count settings
- `GameViewController.swift` — main gameplay, timer and scoring logic
- `ScoreViewController.swift` — leaderboard display
- `ScoreTableViewCell.swift` — custom leaderboard table cell
- `Main.storyboard` — application interface and navigation
- `Assets.xcassets` — application colours and icons

## Academic Context

This project was originally developed as a UIKit-based university assignment and was later updated to correct gameplay, timer and leaderboard issues.

It is intended as a student portfolio project rather than a production-ready mobile application.
