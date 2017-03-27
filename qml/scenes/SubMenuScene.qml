import VPlay 2.0
import QtQuick 2.0
import "../common"

// EMPTY SCENE
SceneBase {
    id: subMenuScene

    signal resumePressed
    signal optionsPressed
    signal mainMenuPressed

    Column {
        id: buttonColumn

        anchors.centerIn: parent
        spacing: 1

        MenuButton {
            text: "Resume"
            lightColor: "#7aef76"
            darkColor: "#00d209"
            borderColor: "#009210"
            onClicked: resumePressed()
        }

        MenuButton {
            text: "Main Menu"
            lightColor: "#ff7db2"
            darkColor: "#f50030"
            borderColor: "#a5002e"
            onClicked: mainMenuPressed()
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



