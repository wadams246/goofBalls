import VPlay 2.0
import QtQuick 2.0

Item {
    id: hud
    width: gameScene.width
    height: 20

    Rectangle {
        anchors.fill: hud
        color: "#666666"

        XpBar {
            anchors {
                bottom: parent.top
                left: parent.left
                right: parent.right
            }
        }

        HpBar {
            anchors {
                left: parent.left
                leftMargin: 10
            }
        }

        StatsBar {
            anchors.top: parent.top
            anchors.topMargin: 1
            anchors.right: parent.right
            anchors.rightMargin: 10
        }

    }

}
