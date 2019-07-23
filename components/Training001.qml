import QtQuick 2.12
import QtQuick.Layouts 1.12

Item {
    property bool swap: false
    property bool shuffle: false
    property Component header: Component {
        RowLayout {
            anchors.fill: parent
            Image {
                id: swapWords
                source: "qrc:/svg/swap-horizontal.svg"
                sourceSize.width: parent.height
                sourceSize.height: parent.height
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        swap = !swap
                    }
                }
            }
            Image {
                id: shuffleWords
                source: "qrc:/svg/shuffle-variant.svg"
                sourceSize.width: parent.height
                sourceSize.height: parent.height
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        shuffle = !shuffle
                        controller.shuffleWords(shuffle)
                    }
                }
            }
        }
    }

    property var word: controller.getNextWord()

    property string current_word1: word.foreign_word
    property string current_word2: word.native_word
    property string previous_word1: ""
    property string previous_word2: ""

    property int max_font_size: fraction * 3
    property var reduce_ratio: 0.5 // коэффициент уменьшения шрифта
    property int reduced_font_size: 0 // временная переменная

    property Component body: Component {
        Rectangle {
            anchors.fill: parent
            color: "gainsboro"
            Text {
                id: previousWord
                anchors.top: parent.top
                width: parent.width
                fontSizeMode: Text.HorizontalFit
                horizontalAlignment: Text.AlignHCenter
                text: previous_word1+"<br>"+previous_word2
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
                anchors.top: parent.verticalCenter
                width: parent.width
                font.pixelSize: max_font_size
                fontSizeMode: Text.HorizontalFit
                horizontalAlignment: Text.AlignHCenter
                text: current_word1+"<br><font color='transparent'>"+current_word2+"</font>"
                states: [
                    State {
                        name: "up";
                        PropertyChanges {
                            target: currentWord;
                            color: "gray";
                            font.pixelSize: reduced_font_size // цифровые значения меняются в NumberAnimation
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
                            if (currentWord.state == "up" && !running) { // анимация закончилась
                                previous_word1 = current_word1
                                previous_word2 = current_word2
                                word = controller.getNextWord() // берём следующее слово

                                if(swap)
                                {
                                    current_word1 = word.native_word
                                    current_word2 = word.foreign_word
                                } else {
                                    current_word1 = word.foreign_word
                                    current_word2 = word.native_word
                                }

                                currentWord.state = "" // возвращаем дефолтное состояние
                                currentWord.text = current_word1+"<br><font color='transparent'>"+current_word2+"</font>"
                                currentWord.font.pixelSize = max_font_size

                                previousWord.state = "visible"
                                previousWord.font.pixelSize = reduced_font_size
                            }
                        }
                    }
                ]
            }
            MouseArea {
                id: clickOnScreen
                anchors.fill: parent
                onClicked: {
                    reduced_font_size = currentWord.fontInfo.pixelSize * reduce_ratio

                    currentWord.state = "up"
                    currentWord.text = current_word1 + "\n" + current_word2
                    currentWord.font.pixelSize = currentWord.fontInfo.pixelSize

                    previousWord.state = "invisible"
                }
            }
        }
    }
}
