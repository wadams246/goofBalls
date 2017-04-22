import VPlay 2.0
import QtQuick 2.0

Item {

    id: clouds

    CloudSmall {
        xPos: menuScene.gameWindowAnchorItem.width * .15
    }
    CloudSmall {
        xPos: menuScene.gameWindowAnchorItem.width * .5
    }
    CloudSmall {
        xPos: menuScene.gameWindowAnchorItem.width
    }
    CloudSmall {
        xPos: menuScene.gameWindowAnchorItem.width * 1.5
    }
    CloudBig {
        xPos: menuScene.gameWindowAnchorItem.width * .30
    }
    CloudBig {
        xPos: menuScene.gameWindowAnchorItem.width * .70
    }
    CloudBig {
        xPos: menuScene.gameWindowAnchorItem.width * 1.15
    }
}
