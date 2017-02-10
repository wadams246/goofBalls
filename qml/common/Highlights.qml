import VPlay 2.0
import QtQuick 2.0

Item {
    id: highLights

    property bool ignoreParentRotation: true
    property point ballCenter: mapFromItem(parent, highLights.parent.width * 0.5, highLights.parent.height * 0.5)

    Rotation { id: reverseRotation; origin.x: ballCenter.x; origin.y: ballCenter.y; angle: -highLights.parent.rotation }
    transform: ignoreParentRotation ? reverseRotation : null

    property alias absoluteX: nonRotatedItem.x
    property alias absoluteY: nonRotatedItem.y

    Item {
        id: nonRotatedItem
        width: highLights.width
        height: highLights.height

        Image {
            id: ballShadow
            width: highLights.width
            height: highLights.height
            source: "../../assets/img/balls/ballHighlights.png"
        }
    }
}
