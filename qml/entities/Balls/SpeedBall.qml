import VPlay 2.0
import QtQuick 2.0
import "../../common"

Ball {
    id: speedBall

    baseHp: 100
    baseXp: 400
    baseBouncePoints: 10
    baseKillPoints: 500
    startBounce: -1000
    tapBounce: -800
    leftRight: -15
    baseDmgPoints: 45
    gScale: 8
    lScale: 2
    ballPic: "yellowBall"
}
