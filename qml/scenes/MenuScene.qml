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
    signal howToPressed

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        Image {
            anchors.fill: parent
            source: "../../assets/img/background/background.png"
        }
        Clouds {
            id: clouds
        }
    }

    // logo
    Item {
        id: logo
        width: 250 * 1.10
        height: 60 * 1.10
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
        MenuButton {
            text: "HOW TO PLAY"
            lightColor: "#fff410"
            darkColor: "#f7991e"
            borderColor: "#a86800"
            onClicked: howToPressed()
        }
        MenuButton {
            text: "CREDITS"
            lightColor: "#a9d8f4"
            darkColor: "#4eb4e6"
            borderColor: "#228acb"
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

        width: noAddsControl.width
        height: noAddsControl.height
        anchors {
            top: buttonColumn.bottom
            topMargin: 20
            left: buttonColumn.left
        }
    }
    RateLink {
        id: rateLink

        width: noAddsControl.width
        height: noAddsControl.height
        anchors {
            top: buttonColumn.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
            verticalCenter: noAddsControl.verticalCenter
        }
    }
    NoAddsControl {
        id: noAddsControl

        anchors {
            top: buttonColumn.bottom
            topMargin: 20
            right: buttonColumn.right
        }
    }
}
