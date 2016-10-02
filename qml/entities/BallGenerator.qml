import VPlay 2.0
import QtQuick 2.0
import "../entities/Balls"

EntityBase {
    id: ballGenerator
    entityType: "ballGenerator"

    property int rand: 0
    property int bigBallChance: 3
    property int powerUpChance: 0
    property variant balls: ["BlueBall", "RedBall", "SpeedBall", "HealBall", "ShieldBall",
                             "HealerBall", "ShielderBall", "SplitBall", "SplitBuffBall"];
    property variant percentages: [
        [30, 30, 30, 10, 0, 0, 0, 0, 0],
        [20, 30, 30, 20, 0, 0, 0, 0, 0],
        [10, 30, 30, 30, 0, 0, 0, 0, 0],
        [0, 30, 30, 30, 10, 0, 0, 0, 0],
        [0, 20, 30, 30, 20, 0, 0, 0, 0],
        [0, 10, 30, 30, 30, 0, 0, 0, 0],
        [0, 0, 30, 30, 30, 10, 0, 0, 0],
        [0, 0, 20, 30, 30, 20, 0, 0, 0],
        [0, 0, 10, 30, 30, 30, 0, 0, 0],
        [0, 0, 10, 25, 25, 30, 10, 0, 0],
        [0, 0, 10, 20, 20, 30, 20, 0, 0],
        [0, 0, 10, 20, 20, 20, 30, 0, 0],
        [0, 0, 10, 15, 15, 20, 30, 10, 0],
        [0, 0, 10, 10, 10, 20, 30, 20, 0],
        [0, 0, 10, 10, 10, 20, 20, 20, 10],
        [0, 0, 10, 10, 10, 15, 15, 20, 20]
    ];

    function levelOne() {
        rand = Math.floor(utils.generateRandomValueBetween(0, 101));
        if(rand < 41) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/GreenBall.qml"));
        } else {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/BlueBall.qml"));
        }
//        genPowerUp();
    }
    function levelTwo() {
        rand = Math.floor(utils.generateRandomValueBetween(0, 101));
        if(rand < 11) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/RedBall.qml"));
        } else if(rand < 41) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/BlueBall.qml"));
        } else {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/GreenBall.qml"));
        }
//        genPowerUp();
    }
    function levelThree() {
        rand = Math.floor(utils.generateRandomValueBetween(0, 101));
        if(rand < 31) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/RedBall.qml"));
        } else if(rand < 71) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/BlueBall.qml"));
        } else {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/GreenBall.qml"));
        }
//        genPowerUp();
    }
    function levelFour() {
        rand = Math.floor(utils.generateRandomValueBetween(0, 101));
        if(rand < 11) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/SpeedBall.qml"));
        } else if(rand < 26) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/GreenBall.qml"));
        } else if(rand < 61) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/BlueBall.qml"));
        } else {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/RedBall.qml"));
        }
//        genPowerUp();
    }
    function levelPlus(lvl) {
        rand = Math.floor(utils.generateRandomValueBetween(1, 101));
        var temp = 0;
        var level = (lvl - 5 > (percentages.length - 1)) ? percentages.length - 1 : lvl - 5;

        if(rand < bigBallChance) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/BigBall.qml"));
        }

        for(var i = 0; i < percentages.length; i++) {
            temp += percentages[level][i];
            if(rand < temp + 1) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/" + balls[i] + ".qml"));
                break;
            }
        }
//        genPowerUp();
    }

    function increaseBBChance() {
        bigBallChance = bigBallChance < 10 ? bigBallChance += 1 : 10
        console.log("BIGBALL CHANCE: ", bigBallChance);
    }

    function genPowerUp() {
        var pRand = Math.floor(utils.generateRandomValueBetween(1, 101));
        if(pRand < powerUpChance + 1) {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/PowerUp.qml"));
            powerUpChance = 0;
        } else {
            powerUpChance += 1;
        }

    }
}
