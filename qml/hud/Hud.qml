import QtQuick 2.0

Rectangle {
    id: hud
    width: 100
    height: 34

    radius: 6
    border.color: "#0015c5"
    border.width: 1.5
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#5593ff" }
        GradientStop { position: 1.0; color: "#0043df" }
    }

    LevelText {
        anchors {
            left: hud.left
            leftMargin: 4
            verticalCenter: hud.verticalCenter
        }
    }

    HpBar {
        id: hpBar
        hpPercent: (player.hp / player.totalHp)
        anchors {
            right: hud.right
            rightMargin: 4
            top: hud.top
            topMargin: 6
        }
    }

    XpBar {
        id: xpBar
        xpPercent: (player.xp / player.toNextLevel)
        anchors {
            right: hud.right
            rightMargin: 4
            top: hpBar.bottom
            topMargin: 2
        }
    }
}
