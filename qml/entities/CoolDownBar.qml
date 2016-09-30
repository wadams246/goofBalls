import VPlay 2.0
import QtQuick 2.0

Item {
    id: coolDownBar

    property int coolDownTime: 2
    property bool ignoreParentRotation: true
    property point ballCenter: mapFromItem(parent, coolDownBar.parent.width * 0.5, coolDownBar.parent.height * 0.5)

    Rotation { id: reverseRotation; origin.x: ballCenter.x; origin.y: ballCenter.y; angle: -coolDownBar.parent.rotation }
    transform: ignoreParentRotation ? reverseRotation : null

    property alias absoluteX: nonRotatedItem.x
    property alias absoluteY: nonRotatedItem.y

    Item {
        id: nonRotatedItem
        width: coolDownBar.width
        height: coolDownBar.height

        Rectangle {
            width: coolDownBar.width
            height: coolDownBar.height
            color: "black"
            opacity: 1
            radius: 1
            anchors.right: parent.right
        }

        Rectangle {
            id: cdBar
            width: coolDownBar.width
            height: coolDownBar.height
            color: "#0099ff"
            opacity: 1
            radius: 1

            NumberAnimation on width {
                id: cdAnimation
                to: 0
                duration: coolDownTime * 1000
                onStopped: nonRotatedItem.opacity = 0
            }
        }
    }

    function resetCD() {
        coolDownTime = 5;
        nonRotatedItem.opacity = 1;
        cdBar.width = coolDownBar.width;
        cdAnimation.stop();
        cdAnimation.start();
    }
}
