import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../scenes"

Item {
    id: xpBar
    width: gameScene.width
    height: 4

    Rectangle {
        id: xp
        height: 4
        width: Math.ceil(gameScene.width * (player.xp / player.toNextLevel))
        anchors.left: parent.left
        color: "yellow"

    }
}
