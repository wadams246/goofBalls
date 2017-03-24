import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../scenes"

Item {
    id: xpBar

    width: 60
    height: 9

    property real xpPercent: 1

    Rectangle {
        id: xpBack
        width: xpBar.width
        height: xpBar.height
        radius: 2
        color: "#0015c5"
    }

    Rectangle {
        width: xpBar.width * xpPercent
        height: xpBar.height
        radius: 2
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#fff410" }
            GradientStop { position: 1.0; color: "#f7991e" }
        }
    }
}
