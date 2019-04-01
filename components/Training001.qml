import QtQuick 2.0

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
        color: "cyan"
        Text {
            anchors.bottom: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: fraction * 2
            text: previous_word1+" - "+previous_word2
        }
        Text {
            id: moving_text
            anchors.top: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize : fraction * 4
            text: current_word1
            MouseArea { id: mouseArea; anchors.fill: parent }
            states: State {
                name: "up";
                PropertyChanges { target: moving_text; color: "red" }
                AnchorChanges { target: moving_text; anchors.top: parent.top }
            }
            transitions: Transition {

                from: ""; to: "up";

                ParallelAnimation {
                    //                                   NumberAnimation { properties: "y"; duration: 500; easing.type: Easing.InOutQuad }
                    ColorAnimation { duration: 500 }
                    AnchorAnimation { duration: 500 }
                }
            }
        }
        MouseArea {
            id: clickOnScreen
            anchors.fill: parent
            onClicked: {
                var word = controller.getNextWord()
                previous_word1 = current_word1
                previous_word2 = current_word2
                current_word1 = word.native_word
                current_word2 = word.foreign_word
                moving_text.state = "up"
            }
        }
    }
}
