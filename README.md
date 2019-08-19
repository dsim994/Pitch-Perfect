# Pitch-Perfect

Swift application that uses the AVFoundation framework to record sounds from the microphone and play recorded audio with effects. Six different sound modulations are Slow, Fast, Chipmunk, Darth Varder, Reverb, and Echo Effect.

 <img src="ScreenShots/IMG_0219.PNG" height="500">  <img src="ScreenShots/IMG_0223.PNG" height="500">  <img src="ScreenShots/IMG_0225.PNG" height="500">

### Implementation

2 View Controller Scenes:

* __RecordSoundsViewController__ : When app is launched the user is presented with a microphone image as a record button. Pressing this starts an audio recording session and presents a pause and stop button. When pause button is pressed, a play button is displayed that starts recording where they left off. When stop button is pressed, the app completes recording and  segue is triggered to PlaySoundsViewController.

* __PlaySoundsViewController__ : Contains six buttons to play the recorded sound file with different effects related to the button image. The stop button is displayed at the bottom which ends your session and directs you back to the RecordSoundsViewController to begin a new recording.

### Requirements
* Xcode 10
* Swift 5.0
