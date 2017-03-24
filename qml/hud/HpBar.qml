import VPlay 2.0
import QtQuick 2.0

Item {
    id: hpBar

    width: 60
    height: 12

    property real hpPercent: 1

    Rectangle {
        id: hpBack

        width: hpBar.width
        height: hpBar.height
        radius: 2
        color: "#f50030"
    }

    Rectangle {
        width: hpBar.width * hpPercent
        height: hpBar.height

        radius: 2
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#7aef76" }
            GradientStop { position: 1.0; color: "#00d209" }
        }
    }
}
