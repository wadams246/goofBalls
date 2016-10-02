import VPlay 2.0
import QtQuick 2.0

Item {
    id: hpBar

    width: 75
    height: 7

    Image {
        id: hpBack
        anchors.fill: parent
        source: "../../assets/img/hud/hpBarBack.png"
    }

    Image {
        width: 75 * (player.hp / player.totalHp)
        height: 7
        anchors.left: hpBack.left
        anchors.verticalCenter: hpBack.verticalCenter
        source: "../../assets/img/hud/hpBar.png"
    }
}
