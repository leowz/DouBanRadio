# DouBanRadio

![platform](https://img.shields.io/badge/platform-iOS%20%209.0%2B-lightgrey.svg)
![vesion](https://img.shields.io/badge/version-swift3-ff69b4.svg)

DouBanRadio is an online streaming radio app adapting DouBanMusic API to provide quality online streaming music service.

1. [Introduction](#Introduction)
2. [APP Behaviour](#APP Behaviour)
  - [Features](# Features)
  - [Music Play Controller](#Music Play)
  - [Channel List Controller](#Channel List)
3. [Others](#Others)

------------------------------------------

#### Introduction
DouBanRadio implement DouBanMusic API to provide quality straming music service. This is  a prototype app. It can play streaming music from the service, get certains information about the music been playing, list out certains music channels and the music in those channels, playing music in background and so on.
---
>   
![video1](video1.gif);  ![video2](video2.gif)
>
---
#### APP Behaviour
The basic APP behaviour goes as follows:
  1. when app is launched the defaut channel are load with songs in it, Music play controller appears. On select any songs in music play table view, the song plays immediately. Album image of this song are load on the background image and on the Album image view. Album image view starts to rotate and time label starts to back play the duration of the song.
  2. On select channel list button, Channel list controller appears. Channels fetch from the API are listed in the table view. When select one channel, channel list controller will dismiss and music play controller will reappear with songs fetched from selected channel are display in the table view.
  3. Mode button is used to indicate the behaviour after one song is finished.
  4. Next and Previous button are used to change songs.
##### Features
- [x] streaming music
- [x] browing channel list
- [x] alboum image display
- [x] background playing
- [x] remote Control
- [x] music play mode switch
- [x] MVVM pattern

##### Music Play Controller
The main interface which include control buttons to control audio player behaviour, list button to segue to Channel controller, song table view for displaying songs in that channel, album image and time label for displaying details of that song.
##### Channel List Controller
Controller for channel list which displays channels given by API.Select one channel to go back to orginal controller with songs in table view.   

#### Others
Alamofire and SwiftyJSON are included in this project.
