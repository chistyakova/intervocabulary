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
            id: currentWord
            anchors.centerIn: parent
            font.pixelSize : 48
            text: previous_word1+"-"+previous_word2+"<br><b>"+current_word1+"</b>"
        }
        Image {
            source: "qrc:///svg/next.svg"
            sourceSize.width: 72
            sourceSize.height: 72
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var word = controller.getNextWord()
                    previous_word1 = current_word1
                    previous_word2 = current_word2
                    current_word1 = word.native_word
                    current_word2 = word.foreign_word
                }
            }
        }
    }
}
