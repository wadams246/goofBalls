import VPlay 2.0
import QtQuick 2.0
import "../common"

// EMPTY SCENE
SceneBase {
    id: confirmScene

    signal confirmPressed
    signal cancelPressed

    property alias text: confirmText.text

    Rectangle{
        id: confirmBox
        width: 250
        height: 75

        anchors.centerIn: parent

        radius: 6
        border.width: 1.5
        border.color: "#a86800"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#fff410" }
            GradientStop { position: 1.0; color: "#f7991e" }
        }

        Text {
            id: confirmText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            font.family: riffic.name
            color: "white"
            style: Text.Outline
            styleColor: "#a86800"
        }

        Row {

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            spacing: 1

            MenuButton {
                text: "YES"
                width: 100
                lightColor: "#7aef76"
                darkColor: "#00d209"
                borderColor: "#009210"
                onClicked: confirmPressed()
            }
            MenuButton {
                text: "NO"
                width: 100
                lightColor: "#ff7db2"
                darkColor: "#f50030"
                borderColor: "#a5002e"
                onClicked: cancelPressed()
            }
        }
    }
}

