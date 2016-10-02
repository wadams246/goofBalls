import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../scenes"

Item {
    id: hpBar

    width: 75
    height: 7

    Image {
        id: hpBack
        anchors.fill: parent
        source: "../../assets/img/hud/xpBarBack.png"
    }

    Image {
        width: 75 * (player.xp / player.toNextLevel)
        height: 7
        anchors.left: hpBack.left
        anchors.verticalCenter: hpBack.verticalCenter
        source: "../../assets/img/hud/xpBar.png"
    }
}
