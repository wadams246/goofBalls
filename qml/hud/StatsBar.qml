import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../scenes"

Item {
    id: statsBar

    Text {
        anchors.right: parent.right
        text: "Max HP: " + player.totalHp + "   Power: " + player.power
        color: "black"
    }
}
