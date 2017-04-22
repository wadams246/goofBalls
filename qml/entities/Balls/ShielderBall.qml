import VPlay 2.0
import QtQuick 2.0
import "../"
import "../../common"

Ball {
    id: shielderBall

    baseHp: 250
    baseXp: 450
    baseBouncePoints: 15
    baseKillPoints: 550
    startBounce: -350
    tapBounce: -280
    baseDmgPoints: 20
    gScale: 1
    lScale: 0
    ballPic: "lightBlueBall"
    cat: Circle.Category5

    property int haste: Math.floor(((player.level - 8) / 2));
    property int coolDownTime: 2
    property int shieldPower: 50 + Math.ceil((player.level / 25) * 50);
    property bool coolDown: true

    CircleCollider {
        id: shieldRange
        radius: parent.width
        x: -radius / 2
        y: -radius / 2

        categories: Circle.Category3
        collidesWith: Circle.Category1 | Circle.Category4
        collisionTestingOnlyMode: true
        fixture.onContactChanged: {
            var collidedEntity = other.getBody().target
            if(!coolDown && collidedEntity.entityType === "ball") {
                var createdEntity = entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../ShieldBolt.qml"), {"ball": shielderBall, "entity": collidedEntity});
                collidedEntity.shield(shieldPower);
                coolDown = true;
                coolDownTime = 5
                coolDownBar.resetCD();
            }
        }
    }

    Rectangle {
        id: rangeIndicator
        width: shielderBall.width * 2
        height: shielderBall.width * 2
        radius: width / 2
        x: shieldRange.x
        y: shieldRange.y
        color: "white"
        opacity: .1

    }

    CoolDownBar {
        id: coolDownBar
        absoluteX: 0
        absoluteY: -coolDownBar.height
        width: shielderBall.width
        height: 5
        coolDownTime: coolDownTime
        visible: true
    }

    Timer {
        interval: 1000
        repeat: true
        running: coolDownTime > 0
        onTriggered: {
            coolDownTime--
            if(coolDownTime === 0) {
                coolDown = false
            }
        }
    }
}


