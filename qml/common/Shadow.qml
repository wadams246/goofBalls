import VPlay 2.0
import QtQuick 2.0

Item {
    id: shadow

    property bool ignoreParentRotation: true
    property point ballCenter: mapFromItem(parent, shadow.parent.width * 0.5, shadow.parent.height * 0.5)

    Rotation { id: reverseRotation; origin.x: ballCenter.x; origin.y: ballCenter.y; angle: -shadow.parent.rotation }
    transform: ignoreParentRotation ? reverseRotation : null

    property alias absoluteX: nonRotatedItem.x
    property alias absoluteY: nonRotatedItem.y

    Item {
        id: nonRotatedItem
        width: shadow.width
        height: shadow.height

        Image {
            id: ballShadow
            width: shadow.width
            height: shadow.height
            source: "../../assets/img/balls/ballShadow.png"
        }
    }
}
