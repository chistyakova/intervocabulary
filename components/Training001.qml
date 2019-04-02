import QtQuick 2.12

Item {
    property string current_word1: ""
    property string current_word2: ""
    property string previous_word1: ""
    property string previous_word2: ""
    Component.onCompleted: {
        var word = controller.getNextWord()
        current_word1 = word.foreign_word
        current_word2 = word.native_word
    }
    Rectangle {
        anchors.fill: parent
        color: "gainsboro"
        Text {
            id: previousWord
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: fraction * 2
            text: previous_word1+"\n"+previous_word2
            color: "gray"
            states: [
                State { name: "visible"
                    PropertyChanges { target: previousWord; opacity: 1.0; visible: true }
                },
                State { name:"invisible"
                    PropertyChanges { target: previousWord; opacity: 0.0 }
                }
            ]
            transitions: [
                Transition {
                    from: "visible"
                    to: "invisible"
                    NumberAnimation { property: "opacity"; duration: 500}
                },
                Transition {
                    from: "invisible"
                    to: "visible"
                    NumberAnimation { property: "visible"; duration: 0}
                }
            ]
        }
        Text {
            id: currentWord
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            font.pixelSize : fraction * 4
            text: current_word1
            states: [
                State {
                    name: "up";
                    PropertyChanges {
                        target: currentWord;
                        color: "gray";
                        font.pixelSize: fraction * 2 // цифровые значения меняются в NumberAnimation
                    }
                    AnchorChanges {
                        target: currentWord;
                        anchors.top: parent.top // выставляем новый якорь
                    }
                }
            ]
            transitions: [
                Transition {
                    from: ""; to: "up";
                    SequentialAnimation {
                        PauseAnimation { duration: 500 }
                        ParallelAnimation {
                            ColorAnimation { duration: 500 }
                            AnchorAnimation { duration: 500 }
                            NumberAnimation { properties: "font.pixelSize"; duration: 500}
                        }
                    }
                    onRunningChanged: { // сигнал, испускаемый при старте и стопе анимации
                        if (currentWord.state == "up" && !running) { // определяем окончание анимации в состояние "up"
                            var word = controller.getNextWord() // берём следующее слово
                            previous_word1 = current_word1
                            previous_word2 = current_word2
                            current_word1 = word.native_word
                            current_word2 = word.foreign_word
                            currentWord.state = "" // возвращаем дефолтное состояние
                            previousWord.state = "visible"
                            currentWord.text = current_word1
                        }
                    }
                }
            ]
        }
        MouseArea {
            id: clickOnScreen
            anchors.fill: parent
            onClicked: {
                currentWord.state = "up"
                previousWord.state = "invisible"
                currentWord.text = current_word1 + "\n" + current_word2
            }
        }
    }
}
