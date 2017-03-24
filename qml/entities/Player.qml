import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: player
    entityType: "player"

    property int basePower: 10
    property int power: basePower
    property int baseHp: 100
    property int totalHp: 100
    property int hp: baseHp
    property int xp: 0
    property int toNextLevel: 1000
    property int level: 1
    property int armor: 0
    property int score: 0

    function getPower() {
        return power;
    }
    function getPlayerTotalHp() {
        return totalHp;
    }

    function setPlayerTotalHp(hp) {
        totalHp = hp;
    }
    function getplayerHp() {
        return hp;
    }
    function takeDmg(dmg) {
        hp -= dmg;
    }
    function heal(hpPwr) {
        hp = (hp + hpPwr > totalHp) ? totalHp : hp + hpPwr;
    }

    function increasePower() {
        power += Math.ceil(power * .15);
    }
    function increaseHp() {
        increasePower();
        totalHp = 100 + (baseHp * (player.level * .25));
        hp = totalHp; //give full hp on totalHp increaes
    }
    function increaseLevel() {
        level++;
        increaseHp();
        gameScene.showLevelText(level);
    }
    function reset() {
        level = 99;
        hp = baseHp;
        totalHp = baseHp;
        power = basePower;
        xp = 0;
        toNextLevel = 1000;
        score = 0;
    }
    function getLevel() {
        return level;
    }
}
