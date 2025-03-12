import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import fileIO 1.0
import scriptLauncher 1.0

Window {
    visible: true
    width: 815
    height: 640
    color: root.backgroundColor

    Component.onDestruction: {
        if (root.saveonquit === 1) {pad.saveButtons();}
        else {scriptHandler.loadLatestScript();}
    }

    FileIO {
        id: fileHandler
        property string pathToWrite: workDir + "/Mads_APCKontrol/midi/notes.txt";
        property string data: ""

        function writeData(button,offset){
            fileHandler.data = qsTr("dev \"APC MINI\" ch 0 on %1H %2")
                .arg(button.midiNote)
                .arg(button.colorState + offset);
        }

        function updateData(button, reduce = 0){
            if (button.colorState === 3) {fileHandler.writeData(button,2 + button.colorBlink);}
            else if (button.colorState === 2) {fileHandler.writeData(button,1 + button.colorBlink - reduce);}
            else if (button.colorState === 1) {fileHandler.writeData(button,button.colorBlink);}
            else {fileHandler.writeData(button,0);}
        }

        function sendData(){
            fileHandler.write(fileHandler.pathToWrite,fileHandler.data);
            scriptHandler.sendMidiScript();
        }

        function writeSaveData(button,offset){
            pad.midiData += qsTr("on %1H %2\n")
                .arg(button.midiNote)
                .arg(button.colorState + offset);
        }

        function updateSaveData(button, reduce = 0){
            if (button.colorState === 3) {fileHandler.writeSaveData(button,2 + button.colorBlink);}
            else if (button.colorState === 2) {fileHandler.writeSaveData(button,1 + button.colorBlink - reduce);}
            else if (button.colorState === 1) {fileHandler.writeSaveData(button,button.colorBlink);}
            else {fileHandler.writeSaveData(button,0);}
        }
    }

    ScriptLauncher {
        id: scriptHandler
    }

    Item {
        id: root
        readonly property int margin: 50
        readonly property color backgroundColor: "#222222"

        property int saveonquit: 1

        function rectButtonPressed(button) {
            if (button.colorState === 3) {button.colorState = 0} else {button.colorState += 1};
            if (blinkButton.colorBlink === 1 && button.colorState !== 0){button.colorBlink = 1} else {button.colorBlink = 0};
            button.updateBlinkState();

            fileHandler.updateData(button);
            fileHandler.sendData();
        }

        function roundRButtonPressed(button) {
            if (button.colorState === 0) {button.colorState = 1} else {button.colorState = 0};
            if (blinkButton.colorBlink === 1 && button.colorState !== 0){button.colorBlink = 1} else {button.colorBlink = 0};
            button.updateBlinkState();

            fileHandler.updateData(button);
            fileHandler.sendData();
        }

        function roundBButtonPressed(button) {
            if (button.colorState === 0) {button.colorState = 2} else {button.colorState = 0};
            if (blinkButton.colorBlink === 1 && button.colorState !== 0){button.colorBlink = 1} else {button.colorBlink = 0};
            button.updateBlinkState();

            fileHandler.updateData(button, button.colorBlink*2);
            fileHandler.sendData();
        }

        function blinkButtonPressed(button) {
            if (button.colorState === 0) {
                button.colorState = 1
                button.colorBlink = 1
                button.palette.buttonText = "black"
            }
            else {
                button.colorState = 0
                button.colorBlink = 0
                button.palette.buttonText = "white"
            };
        }

        function autoSaveButtonPressed(button) {
            if (root.saveonquit === 1){
                button.text = "OFF"
                button.colorState = 2
                root.saveonquit = 0
            } else {
                button.text = "ON"
                button.colorState = 1
                root.saveonquit = 1
            }
        }

        RowLayout {
            anchors.fill: parent

            Rectangle {
                width: 50   // Largeur de la bordure
                height: parent.height
                color: "#222222"  // Couleur de la bordure
            }

            ColumnLayout {
                anchors.margins: root.margin
                spacing: 25

                Label {
                    text: "APCmini LIGHT KONTROL"
                    font.pixelSize: 48
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }

                Rectangle {
                    width: parent.width
                    height: 4
                    color: "#7d7d7d"  // Couleur grise pour la séparation
                    Layout.fillWidth: true
                }

                ApcPad {
                    id: pad
                }

                Rectangle {
                    width: parent.width
                    height: 4
                    color: "#7d7d7d"  // Couleur grise pour la séparation
                    Layout.fillWidth: true
                }

                RowLayout {
                    anchors.margins: root.margin
                    spacing: 25

                    ApcButton {
                        id: clearButton
                        text: "Clear ALL"
                        palette.buttonText: "white"
                        implicitWidth: 78
                        onReleased: {
                            pad.clearButtons()
                            scriptHandler.clearAllScript()
                        }
                    }

                    ApcButton {
                        id: blinkButton
                        text: "Enable Blink"
                        palette.buttonText: "white"
                        implicitWidth: 78
                        onReleased: {
                            root.blinkButtonPressed(this)
                        }
                    }

                    ApcButton {
                        id: saveButton
                        text: "Save current config"
                        palette.buttonText: "white"
                        implicitWidth: 116
                        onReleased: {
                            pad.saveButtons()
                        }
                    }

                    ApcButton {
                        id: loadButton
                        text: "Load lastest config"
                        palette.buttonText: "white"
                        implicitWidth: 116
                        onReleased: {
                            pad.loadButtons()
                        }
                    }

                    ApcButton {
                        text: "Save on quit :"
                        implicitWidth: 116
                        palette.buttonText: "white"
                        borderColor: "#222222"
                        accentColor: "#222222"
                    }

                    ApcButton {
                        id: autoSaveButton
                        text: "ON"
                        colorState: 1
                        palette.buttonText: "black"
                        onReleased: {
                            root.autoSaveButtonPressed(this)
                        }
                    }
                }
            }
        }
    }
}
