import VPlay 2.0
import QtQuick 2.0
import "../../common"

ShielderBall {
    id: splitShielderBall

    baseHp: 225
    baseXp: 750
    baseBouncePoints: 50
    baseKillPoints: 1750
    startBounce: -280
    tapBounce: -300
    baseDmgPoints: 15
    gScale: 1
    lScale: 1
    ballPic: "lightBlueBall"
    cat: Circle.Category4

    function checkHp () {
        if(hp < 1) {
            killPoints += killPoints * (y / gameScene.height);
            player.score += killPoints;
            calXp(xp);
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../FloatingText.qml"), {
                                                                "x": x + (width / 2),
                                                                "y": y + height,
                                                                "score": killPoints,
                                                                "xp": xp
                                                            });
            audioManager.playSound("pop");
            removeEntity();
        } else {
            audioManager.playSound("bounce");
            moveBall();
        }
    }
}
