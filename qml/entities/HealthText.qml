import VPlay 2.0
import QtQuick 2.0

Item {
    id: healthText

    property real healAmount: 1.0
    property bool ignoreParentRotation: true
    property point ballCenter: mapFromItem(parent, healthText.parent.width * 0.5, healthText.parent.height * 0.5)

    Rotation {
        id: reverseRotation
        origin.x: ballCenter.x
        origin.y: ballCenter.y
        angle: -healthText.parent.rotation
    }
    transform: ignoreParentRotation ? reverseRotation : null

    property alias absoluteX: nonRotatedItem.x
    property alias absoluteY: nonRotatedItem.y

    opacity: 0

    Item {
        id: nonRotatedItem

        Text {
            width: healthText.width
            color: "#08dc05"
            style: Text.Outline
            styleColor: "#ffffff"
            font.family: riffic.name
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            text: "+" + healAmount + " HP"
        }
    }

    Loader {
        id: fadeHealLoader
        onLoaded: {fadeHealText.stop()}
    }
    NumberAnimation on opacity {
        id: healTextFader
        to: 0
        duration: 2000
    }

    function fadeHealText() {
        healTextFader.stop();
        healthText.opacity = 1;
        healTextFader.start();
    }

    function stopAnimation() {
        healTextFader.stop();
        healthText.opacity = 0;
    }
}
