import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"

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
            source: "../../assets/img/background/dayBackground.png"
        }
        Clouds {
            id: clouds
        }
    }

    // the "logo"
    Item {
        id: logo
        width: 250
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        y: 80

        Image {
            id: logoImg
            anchors.fill: parent
            source: "../../assets/img/logo/goofballsTitle.png"
        }
    }

//    Text {
//        anchors.horizontalCenter: parent.horizontalCenter
//        y: 50
//        font.pixelSize: 60
//        color: "#e9e9e9"
//        text: "Goofballs"
//    }

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
