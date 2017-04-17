import VPlay 2.0
import QtQuick 2.0
import './Balls'
import '../entities'
import '../common'

Rectangle {
    id: list

    color: "transparent"

    width: children.width
    height: children.height

    BallInfo {
        id: greenInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: list.top
            topMargin: 10
        }
        pic: "greenBall"
        text: "Average bounce, average fall\n speed, and average HP."
    }

    BallInfo {
        id: blueInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: greenInfo.bottom
        }

        pic: "blueBall"
        text: "Bounces very high, but falls\n very slow, and has high HP."
    }

    BallInfo {
        id: redInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: blueInfo.bottom
        }

        pic: "redBall"
        text: "Very low bounce, falls slow, \nand has very high HP."
    }

    BallInfo {
        id: yellowInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: redInfo.bottom
        }

        pic: "yellowBall"
        text: "Average bounce, very fast fall,\n and very low HP."
    }

    BallInfo {
        id: healInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: yellowInfo.bottom
        }

        pic: "aquaBall"
        text: "Average bounce, average fall,\n and ability to heal themselves."
    }

    BallInfo {
        id: shieldInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: healInfo.bottom
        }

        pic: "orangeBall"
        text: "Average bounce, average fall,\n and ability to shield themselves."
    }
}
