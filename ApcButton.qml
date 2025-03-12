import QtQuick
import QtQuick.Controls

RoundButton {
    id: button
    implicitWidth: 38
    implicitHeight: 38
    radius: buttonRadius
    text: ""
    palette.buttonText: "black"

    property string buttonType : ""

    readonly property int fontSize: 22
    readonly property int buttonRadius: 8

    property color accentColor: "#FFFFFF"
    property int colorState: 0
    property int colorBlink: 0
    property string midiNote: ""

    readonly property color offBackgroundColor: "#222222"
    readonly property color redBackgroundColor: "#FA574B"
    readonly property color greenBackgroundColor: "#2CDE85"
    readonly property color yellowBackgroundColor: "#FAE84B"

    property color borderColor: "#7d7d7d"

    function getBackgroundColor() {
        if (button.pressed)
            return accentColor
        if (button.colorState == 1)
            return greenBackgroundColor
        if (button.colorState == 2)
            return redBackgroundColor
        if (button.colorState == 3)
            return yellowBackgroundColor
        return offBackgroundColor
    }

    function getBorderColor() {
        if (button.pressed || button.hovered)
            return accentColor
        return borderColor
    }

    function updateBlinkState() {
        if (button.colorBlink === 1){
            button.text = "BLINK";
        }
        else {
            button.text = "";
        };
    }

    background: Rectangle {
        radius: button.buttonRadius
        color: getBackgroundColor()
        border.color: getBorderColor()
    }
}
