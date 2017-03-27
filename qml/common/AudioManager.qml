import VPlay 2.0
import QtQuick 2.0
import QtMultimedia 5.0

Item {

    id: audioManager

    BackgroundMusic {
        id: theme
        autoPlay: false
        source: "../../assets/snd/Chippytoon.mp3"
    }

    SoundEffectVPlay {
        id: bounce
        autoPlay: false
        loops: 0
        source: "../../assets/snd/bounce.wav"
    }

    SoundEffectVPlay {
        id: pop
        autoPlay: false
        loops: 0
        source: "../../assets/snd/pop.wav"
    }

    NumberAnimation {
        id: fadeVol
        target: theme
        property: "volume"
        to: 0
        duration: 3500
    }

    function playMusic(music) {
        if(music === "theme") {
            theme.play();
        }
    }

    function stopMusic(music) {

        if(music === "theme") {
            fadeVol.start();
        }
    }

    function playSound(sound) {
        if(sound === "bounce") {
            bounce.stop();
            bounce.play();
        } else if(sound === "pop") {
            pop.stop();
            pop.play();
        }
    }
    function muteSounds() {
        theme.muted = !theme.muted;
        bounce.muted = !bounce.muted;
        pop.muted = !pop.muted;
    }
}
