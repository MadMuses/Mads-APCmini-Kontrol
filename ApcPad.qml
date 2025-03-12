pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Item {
    id: controller
    implicitWidth: mainPadGrid.width
    implicitHeight: mainPadGrid.height
    Component.onCompleted: loadButtons()

    readonly property int spacing: 5
    property string midiData: ""

    // Init le dico pour aller chercher les equivalents vélocité variables :
    readonly property var velocityDict: {
        "RectButton"    : {
            "0" : [0,0],
            "1" : [1,0],
            "2" : [1,1],
            "3" : [2,0],
            "4" : [2,1],
            "5" : [3,0],
            "6" : [3,1]
        },
        "RoundRButton"  : {
            "0" : [0,0],
            "1" : [1,0],
            "2" : [1,1],
            "3" : [1,0]
        },
        "RoundBButton"  : {
            "0" : [0,0],
            "1" : [2,0],
            "2" : [2,1],
            "3" : [2,0]
        }
    }

    component RectButton: ApcButton {
        buttonType:"RectButton"
        implicitWidth: 78
        onReleased: {
            root.rectButtonPressed(this)
        }
    }

    component RoundRButton: ApcButton {
        buttonType:"RoundRButton"
        onReleased: {
            root.roundRButtonPressed(this)
        }
    }

    component RoundBButton: ApcButton {
        buttonType:"RoundBButton"
        onReleased: {
            root.roundBButtonPressed(this)
        }
    }

    function clearButtons() {
        for (var i = 0; i < mainPadGrid.children.length; i++) {
            var child = mainPadGrid.children[i];
            child.colorState = 0;
            child.colorBlink = 0;
            child.updateBlinkState();
        }
    }

    function saveButtons() {
        controller.midiData = "dev \"APC MINI\" ch 0 play\n";

        for (var i = 0; i < mainPadGrid.children.length; i++) {
            var child = mainPadGrid.children[i];
            if (child.buttonType === "RoundBButton") {fileHandler.updateSaveData(child, child.colorBlink*2)}
            else {fileHandler.updateSaveData(child, 0)}
        }
        fileHandler.write(workDir + "/Mads_APCKontrol/midi/latest.txt",controller.midiData)
    }

    function loadButtons() {
        var lines = fileHandler.read(workDir + "/Mads_APCKontrol/midi/latest.txt").split("\n")

        // Init le dico pour accéder aux boutons avec une note
        var buttonDict = {};
        for (var j = 0; j < mainPadGrid.children.length; j++) {
            var child = mainPadGrid.children[j];
            buttonDict[child.midiNote] = child;
        }

        // Attribue les infos aux boutons
        for (var i = 0; i < lines.length; i++) {
            var parts = lines[i].trim().split(" ");

            if (parts.length === 3 && parts[0] === "on") {
                var midiNote = parts[1].replace("H", "");
                var velocity = parts[2];

                // On va chercher les états dans le dico de vélocité
                buttonDict[midiNote].colorState = velocityDict[buttonDict[midiNote].buttonType][velocity][0];
                buttonDict[midiNote].colorBlink = velocityDict[buttonDict[midiNote].buttonType][velocity][1];
                buttonDict[midiNote].updateBlinkState();
            }
        }
        scriptHandler.loadLatestScript();
    }

    Rectangle {
        id: mainPad
        anchors.fill: parent
        radius: 8
        color: "transparent"

        RowLayout {
            spacing: controller.spacing

            GridLayout {
                id: mainPadGrid
                columns: 9
                columnSpacing: controller.spacing
                rowSpacing: controller.spacing

                RectButton { midiNote: "38"}
                RectButton { midiNote: "39"}
                RectButton { midiNote: "3A"}
                RectButton { midiNote: "3B"}
                RectButton { midiNote: "3C"}
                RectButton { midiNote: "3D"}
                RectButton { midiNote: "3E"}
                RectButton { midiNote: "3F"}
                RoundRButton { midiNote: "52"}

                RectButton { midiNote: "30"}
                RectButton { midiNote: "31"}
                RectButton { midiNote: "32"}
                RectButton { midiNote: "33"}
                RectButton { midiNote: "34"}
                RectButton { midiNote: "35"}
                RectButton { midiNote: "36"}
                RectButton { midiNote: "37"}
                RoundRButton { midiNote: "53"}

                RectButton { midiNote: "28"}
                RectButton { midiNote: "29"}
                RectButton { midiNote: "2A"}
                RectButton { midiNote: "2B"}
                RectButton { midiNote: "2C"}
                RectButton { midiNote: "2D"}
                RectButton { midiNote: "2E"}
                RectButton { midiNote: "2F"}
                RoundRButton { midiNote: "54"}

                RectButton { midiNote: "20"}
                RectButton { midiNote: "21"}
                RectButton { midiNote: "22"}
                RectButton { midiNote: "23"}
                RectButton { midiNote: "24"}
                RectButton { midiNote: "25"}
                RectButton { midiNote: "26"}
                RectButton { midiNote: "27"}
                RoundRButton { midiNote: "55"}

                RectButton { midiNote: "18"}
                RectButton { midiNote: "19"}
                RectButton { midiNote: "1A"}
                RectButton { midiNote: "1B"}
                RectButton { midiNote: "1C"}
                RectButton { midiNote: "1D"}
                RectButton { midiNote: "1E"}
                RectButton { midiNote: "1F"}
                RoundRButton { midiNote: "56"}

                RectButton { midiNote: "10"}
                RectButton { midiNote: "11"}
                RectButton { midiNote: "12"}
                RectButton { midiNote: "13"}
                RectButton { midiNote: "14"}
                RectButton { midiNote: "15"}
                RectButton { midiNote: "16"}
                RectButton { midiNote: "17"}
                RoundRButton { midiNote: "57"}

                RectButton { midiNote: "08"}
                RectButton { midiNote: "09"}
                RectButton { midiNote: "0A"}
                RectButton { midiNote: "0B"}
                RectButton { midiNote: "0C"}
                RectButton { midiNote: "0D"}
                RectButton { midiNote: "0E"}
                RectButton { midiNote: "0F"}
                RoundRButton { midiNote: "58"}

                RectButton { midiNote: "00"}
                RectButton { midiNote: "01"}
                RectButton { midiNote: "02"}
                RectButton { midiNote: "03"}
                RectButton { midiNote: "04"}
                RectButton { midiNote: "05"}
                RectButton { midiNote: "06"}
                RectButton { midiNote: "07"}
                RoundRButton { midiNote: "59"}

                RoundBButton { midiNote: "40"}
                RoundBButton { midiNote: "41"}
                RoundBButton { midiNote: "42"}
                RoundBButton { midiNote: "43"}
                RoundBButton { midiNote: "44"}
                RoundBButton { midiNote: "45"}
                RoundBButton { midiNote: "46"}
                RoundBButton { midiNote: "47"}
            }
        } // RowLayout
    }
}
