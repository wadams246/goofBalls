import VPlay 2.0
import QtQuick 2.0

Item {
    id: hpBar

    Text {
        id: hpText
        color: "black"

        text: "Lv. " + player.level + " HP"

        Rectangle {
            id: backGround
            anchors.left: hpText.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            height: 12
            width: 74
            border.width: 2
            border.color: "black"
            color: "red"
            radius: 3
        }

        Rectangle {
            id: health
            anchors.left: hpText.right
            anchors.leftMargin: 7
            anchors.verticalCenter: parent.verticalCenter
            height: 8
            width: 70 * (player.hp / player.totalHp)
            color: "#08dc05"
        }
    }

}
