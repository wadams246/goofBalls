import VPlay 2.0
import QtQuick 2.0
import "../hud"

Item {
    id: healthBar

    property real percent: 1.0
    property bool ignoreParentRotation: true
    property point ballCenter: mapFromItem(parent, healthBar.parent.width * 0.5, healthBar.parent.height * 0.5)

    Rotation { id: reverseRotation; origin.x: ballCenter.x; origin.y: ballCenter.y; angle: -healthBar.parent.rotation }
    transform: ignoreParentRotation ? reverseRotation : null

    property alias absoluteX: nonRotatedItem.x
    property alias absoluteY: nonRotatedItem.y

    Item {
        id: nonRotatedItem
        width: healthBar.width
        height: healthBar.height
        opacity: 0

        HpBar {
            id: hpBar
            width: healthBar.width
            height: healthBar.height
            hpPercent: percent
        }

        NumberAnimation on opacity {
            id: fadeHpBarAnimation
            to: 0
            duration: 2500
        }
    }

    function resetBar() {
        fadeHpBarAnimation.stop();
        nonRotatedItem.opacity = 1
        fadeHpBarAnimation.start();
    }
}
