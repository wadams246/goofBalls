import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    signal creditsPressed
    signal scoresPressed
    signal optionsPressed
    signal playPressed
    signal exitPressed

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        Image {
            anchors.fill: parent
            scale: 1.2
            source: "../../assets/img/background.png"
        }
    }


    // the "logo"
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 50
        font.pixelSize: 60
        color: "#e9e9e9"
        text: "Goofballs"
    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 1
        MenuButton {
            text: "Play"
            onClicked: playPressed()
        }
        MenuButton {
            text: "Options"
            onClicked: optionsPressed()
        }
        MenuButton {
            text: "Credits"
            onClicked: creditsPressed()
        }
        MenuButton {
            text: "High Scores"
            onClicked: scoresPressed()
        }
        MenuButton {
            text: "Exit"
            onClicked: exitPressed()
        }
    }

}
