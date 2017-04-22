import VPlay 2.0
import QtQuick 2.0
import "../../common"
import "../"

Ball {
    id: healerBall

    baseHp: 250
    baseXp: 400
    baseBouncePoints: 15
    baseKillPoints: 500
    startBounce: -280
    tapBounce: -300
    baseDmgPoints: 25
    gScale: 1
    lScale: 0
    ballPic: "whiteBall"
    cat: Circle.Category4

    property int coolDownTime: 2
    property bool coolDown: true
    property int healPower: 50 + Math.ceil((player.level / 25) * 50);

    CircleCollider {
        id: healRange
        radius: parent.width
        x: -radius / 2
        y: -radius / 2

        categories: Circle.Category3
        collidesWith: Circle.Category1 | Circle.Category5
        collisionTestingOnlyMode: true
        fixture.onContactChanged: {
            var collidedEntity = other.getBody().target
            if(!coolDown && collidedEntity.entityType === "ball") {
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../HealBolt.qml"), {"ball": healerBall, "entity": collidedEntity});
                collidedEntity.heal(healPower);
                coolDown = true;
                coolDownTime = 5
                coolDownBar.resetCD();
            }
        }
    }

    Rectangle {
        id: rangeIndicator
        width: healerBall.width * 2
        height: healerBall.width * 2
        radius: width / 2
        x: healRange.x
        y: healRange.y
        color: "white"
        opacity: .1

    }

    CoolDownBar {
        id: coolDownBar
        absoluteX: 0
        absoluteY: -coolDownBar.height
        width: healerBall.width
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


