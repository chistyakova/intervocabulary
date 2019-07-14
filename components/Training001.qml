import QtQuick 2.13
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



//    Component.onCompleted: {
//        var word = controller.getNextWord()
//        if(swap)
//        {
//            current_word1 = word.native_word
//            current_word2 = word.foreign_word
//        } else {
//            current_word1 = word.foreign_word
//            current_word2 = word.native_word
//        }
//    }

    property Component body: Component {
        Rectangle {
            anchors.fill: parent
            color: "gainsboro"
            Rectangle {
                id: previousWordRectangle
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.62
                height: parent.height / 2 * 0.62
                Text {
                    id: previousWord
                    anchors.fill: parent
                    font.pixelSize: fraction * 4
                    fontSizeMode: Text.Fit
//                    fontSizeMode: Text.HorizontalFit
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
            }
            Rectangle {
                id: currentWordRectangle
                anchors.top: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height/2
                color: "yellow"
                Text {
                    id: currentWord
                    anchors.fill: parent
                    font.pixelSize: fraction * 4
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    text: current_word1+"<br><font color='transparent'>"+current_word2+"</font>"

                }
                states: [
                    State {
                        name: "up";
                        PropertyChanges {
                            //target: currentWord;
                            target: currentWordRectangle
//                            color: "gray";
//                            font.pixelSize: previousWord.font.pixelSize
                            width: parent.width * 0.62
                            height: parent.height / 2 * 0.62
                        }
                        AnchorChanges {
                            //target: currentWord;
                            target: currentWordRectangle
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
//                                ColorAnimation { duration: 500 }
                                AnchorAnimation { duration: 500 }
//                                NumberAnimation { properties: "font.pixelSize"; duration: 500;}
                                NumberAnimation { properties: "width"; duration: 500;}
                                NumberAnimation { properties: "height"; duration: 500;}
                            }
                        }
                        onRunningChanged: { // сигнал, испускаемый при старте и стопе анимации
                            if (currentWordRectangle.state == "up" && !running) { // определяем окончание анимации в состояние "up"
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

//                                currentWord.state = "" // возвращаем дефолтное состояние
                                currentWordRectangle.state = ""
                                previousWord.state = "visible"
                                currentWord.text = current_word1+"<br><font color='transparent'>"+current_word2+"</font>"
                            }
                        }
                    }
                ]
            }
            MouseArea {
                id: clickOnScreen
                anchors.fill: parent
                onClicked: {
//                    currentWord.state = "up"
                    previousWord.state = "invisible"
                    currentWord.text = current_word1 + "\n" + current_word2
                    currentWordRectangle.state = "up"
                }
            }
        }
        //    Text {
        //        text: "asasd"
        //        anchors.right: parent.right
        //        anchors.top: mainRectangle.top
        //    }
        //    Rectangle {
        //        anchors.fill: parent.parent.parent.parent.heder
        //        color: "red"
        //        Text {
        //            anchors.fill: parent
        //            text: "aaa"
        //        }
        //    }
    }
}
