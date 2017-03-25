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

    // logo
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

    Column {
        id: buttonColumn
        anchors.centerIn: parent
        spacing: 1
        MenuButton {
            text: "PLAY"
            lightColor: "#7aef76"
            darkColor: "#00d209"
            borderColor: "#009210"
            onClicked: playPressed()
        }
        MenuButton {
            text: "HIGH SCORES"
            lightColor: "#ff84fb"
            darkColor: "#e501e4"
            borderColor: "#ac00ab"
            onClicked: scoresPressed()
        }
//        MenuButton {
//            text: "OPTIONS"
//            lightColor: "#fff410"
//            darkColor: "#f7991e"
//            borderColor: "#a86800"
//            onClicked: optionsPressed()
//        }
        MenuButton {
            text: "CREDITS"
            lightColor: "#fff410"
            darkColor: "#f7991e"
            borderColor: "#a86800"
            onClicked: creditsPressed()
        }
        MenuButton {
            text: "EXIT"
            lightColor: "#ff7db2"
            darkColor: "#f50030"
            borderColor: "#a5002e"
            onClicked: exitPressed()
        }
    }
    VolumeControl {
        id: volControl

        anchors {
            bottom: parent.bottom
            bottomMargin: 10
            left: parent.left
            leftMargin: 10
        }
    }
    NoAddsControl {
        id: noAdds

        anchors {
            bottom: parent.bottom
            bottomMargin: 10
            right: parent.right
            rightMargin: 10
        }
    }
}
