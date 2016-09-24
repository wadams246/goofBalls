import VPlay 2.0
import QtQuick 2.0
import "../scenes"
import "../common"

EntityBase {

    entityType: "top"
    width: 1
    height: 1

    BoxCollider {
        categories: Box.Category3
        anchors.fill: parent
        bodyType: Body.Static
        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target;
            console.debug("ceiling hit");
            collidedEntity.heal(Math.ceil(collidedEntity.totalHp * .2));
//            collidedEntity.hp += Math.ceil(collidedEntity.totalHp * .2)
//            collidedEntity.hp = (collidedEntity.hp > collidedEntity.totalHp) ? collidedEntity.totalHp : collidedEntity.hp

        }
    }
}
