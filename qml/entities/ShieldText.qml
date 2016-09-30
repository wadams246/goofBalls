import VPlay 2.0
import QtQuick 2.0

Item {
    id: shieldText

    property real shieldAmount: 1.0
    property bool ignoreParentRotation: true
    property point ballCenter: mapFromItem(parent, healthText.parent.width * 0.5, healthText.parent.height * 0.5)

    Rotation { id: reverseRotation; origin.x: ballCenter.x; origin.y: ballCenter.y; angle: -healthText.parent.rotation }
    transform: ignoreParentRotation ? reverseRotation : null

    property alias absoluteX: nonRotatedItem.x
    property alias absoluteY: nonRotatedItem.y

    opacity: 0

    Item {
        id: nonRotatedItem

        Text {
            width: shieldText.width
            color: "#0099ff"
            font.pixelSize: 8
            horizontalAlignment: Text.AlignHCenter
            text: "+" + shieldAmount + " Shield"
        }

    }

    Loader {
        id: fadeShieldLoader
        onLoaded: {fadeShieldText.stop()}
    }
    NumberAnimation on opacity {
        id: shieldTextFader
        to: 0
        duration: 2000
    }

    function fadeShieldText(sp) {
        shieldAmount = sp;
        shieldTextFader.stop();
        shieldText.opacity = 1;
        shieldTextFader.start();
    }

    function stopAnimation() {
        shieldTextFader.stop();
        shieldText.opacity = 0;
    }
}
