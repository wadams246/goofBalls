import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: creditsScene

    Rectangle {
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        color: "#0043df"
    }

    // back button
    MenuButton {
        text: "Back"

        anchors {
            right: parent.gameWindowAnchorItem.right
            rightMargin: 10
            top: parent.gameWindowAnchorItem.top
            topMargin: 10
        }
        width: 80
        lightColor: "#ff7db2"
        darkColor: "#f50030"
        borderColor: "#a5002e"
        onClicked: backButtonPressed()
    }

    // credits
    Column {
        id: credits
        anchors.centerIn: parent
        spacing: 10

        Credit {
            id: gameDevCred

            title: "GAME DEVELOPMENT"
            name: "William Adams"
        }
        Credit {
            id: graphics

            title: "GRAPHICS"
            name: "William Adams"
        }

        Credit {
            id: theme

            title: "THEME SONG"
            name: "Chippy Toon"
        }
        Credit {
            id: soundEffects

            title: "SOUND EFFECTS"
            name: "Sound Effects"
        }
    }
}
