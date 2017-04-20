import VPlay 2.0
import QtQuick 2.0
import "../../common"
import "../../scenes"

Ball {
    id: bigBall

    signal bigBallKilled

    width: 100
    height: 100
    baseHp: 1000 * .60
    baseBouncePoints: 5
    baseXp: 1500
    baseKillPoints: 1000
    startBounce: 0
    tapBounce: 0
    dmgPoints: 1000
    gScale: .08
    spriteWidth: 100
    spriteHeight: 100
    ballPic: "purpleBall"
    bigBall: true

    BoxCollider {
        collidesWith: Box.Category2 | Box.Category4
        id: collider
        gravityScale: gScale
        linearDamping: lScale
        categories: Circle.Category1
        fixture.restitution: 1
    }

//    MouseArea {
//        id: mouse
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.horizontalCenter: parent.horizontalCenter
//        width: parent.width
//        height: parent.height
//        onPressed: {
//            bounce(player.power)
//        }
//    }

    Component.onCompleted: {
        x = utils.generateRandomValueBetween(0, gameScene.width-150)
        y = 20
    }

    Component.onDestruction: {
        bigBallKilled();
    }
}
