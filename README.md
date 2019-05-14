# Pitch-Perfect
### iOS Development Nanodegree Project


Pitch Perfect is a swift application that allow users to Record a sound using the Device’s Microphone. The user can then play the recorded sound back with six different Sound Modulations:  Slow, Fast, Chipmunk, Darth Vader, Reverb, and Echo effect.


 <img src="ScreenShots/IMG_0219.PNG" height="500">  <img src="ScreenShots/IMG_0223.PNG" height="500">  <img src="ScreenShots/IMG_0225.PNG" height="500">

### Implementation

Pitch Perfect has two Scenes:

* __RecordSoundsViewController__ : Contains a microphone image as a record button. Tapping this microphone starts an audio recording session and presents a pause and stop button. When the pause button is clicked, a play button is displayed that the user can press to start the recording where they left off. When the stop button is clicked, the app completes the recording and a segue is triggered to PlaySoundsViewController.

* __PlaySoundsViewController__ : Contains six buttons to play the recorded sound file with different effects related to the button image. A stop button is displayed at the bottom which ends your session and directs you to the recording screen.

This application uses code from AVFoundation to record the sounds from the microphone (AVAudioRecorder) and play recorded audio with effects (AVAudioPlayer, AVAudioEngine).

### Requirements
* Xcode 10
* Swift 5.0
