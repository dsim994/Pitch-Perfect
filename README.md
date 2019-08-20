# Pitch-Perfect

Swift application that uses the AVFoundation framework to record sounds from the microphone and play recorded audio with effects. Six different sound modulations are Slow, Fast, Chipmunk, Darth Varder, Reverb, and Echo Effect.

 <img src="ScreenShots/IMG_0219.PNG" height="500">  <img src="ScreenShots/IMG_0223.PNG" height="500">  <img src="ScreenShots/IMG_0225.PNG" height="500">

### Implementation

2 View Controller Scenes:

* __RecordSoundsViewController__ : Upon launch user is presented with a microphone image as a record button. Pressing this starts an audio recording session which then presents a pause and stop button. When pause button is pressed, a play button is displayed that starts recording where they left off. When stop button is pressed, the app completes recording and directs you to PlaySoundsViewController.

* __PlaySoundsViewController__ : View contains six buttons that play the recorded sound file with different sound modulations related to each button image. You can play the recording as many times with every sound option available, but when the stop button displayed at the bottom is pressed your session will be ended and you will be directed back to RecordSoundsViewController to begin a new recording.

### Requirements
* Xcode 10
* Swift 5.0
