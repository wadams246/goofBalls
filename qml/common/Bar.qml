import VPlay 2.0
import QtQuick 2.0

EntityBase {

    entityId: "entity"
    entityType: "customEntity"

    property string backId: "backId"
    property string barId: "barId"

    Rectangle {
        id: backId
        anchors.bottom: parent.top
        height: 5
        width: spriteWidth
        color: "red"
        opacity: 0
        radius: 1

        Loader {
            id: hpBarBackLoader
            onLoaded: {fadeHpBack.stop()}
        }
        NumberAnimation on opacity {
            id: fadeHpBack
            to: 0
            duration: 2500
        }
    }

    Rectangle {
        id: barId
        anchors.bottom: parent.top
        height: 5
        width: spriteWidth * (hp / totalHp)
        color: "#08dc05"
        opacity: 0
        radius: 1

        Loader {
            id: hpBarLoader
            onLoaded: {fadeHp.stop()}
        }
        NumberAnimation on opacity {
            id: fadeHp
            to: 0
            duration: 2500
        }
    }
}
