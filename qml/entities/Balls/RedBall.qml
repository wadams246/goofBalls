import VPlay 2.0
import QtQuick 2.0
import "../../common"

Ball {
    id: redBall

    baseHp: 125
    baseXp: 225
    baseBouncePoints: 5
    baseKillPoints: 225
    startBounce: -300
    tapBounce: -200
    baseDmgPoints: 25
    gScale: 1
    lScale: .5
    ballPic: "lightRedBall"
}
