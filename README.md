# Mad's APCmini mk1 light Kontrol
A graphic interface made to kontrol the available lights on an APCmini mk1. This works by sending specific midi notes and velocity to the midi ch 0 of the controller.

## Usage

* Clicking on a button will cycle through the available colors for a button.
* If the blink button is cliked, clicking on any button will now cycle through the available blinking colors.
* The software will automatically load the last configuration saved when opened.
* By default, the current configuration will be saved when the software is closed. This can be turned off by clicking the save on close button and having it on OFF (red).
* Only one configuration can be saved at a time. Clicking the save config button will save the current config and clicking on the load latest will load the saved config.
* The clear all button clears the entire AKAI bord.

## WARNING

* This software only guarentees to light up the buttons on the controller, it does not currently receive midi information from the controller.
* The shift button does not seem to be lightable using the midi control commands.
* This is made to work only on Windows and was tested on windows 10 only. There is no plan to adapt the code for macOS or Linux.

## Building

* This project is my first qml/qt6 project and was made using the QtCreator app. Follow the qt documentation to import a project.
