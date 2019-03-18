import QtQuick 2.0
import QtQuick.Controls 2.0

Component {
    id: addWordComponent
    Rectangle {
        color: "#00ffff"
        Button {
            anchors.top: parent.top
            anchors.left: parent.left
            text: "< НАЗАД"
            onClicked: stack.pop()
        }
        Column {
            anchors.centerIn: parent
            width: parent.width
            Button {
                width: parent.width
                text: "ОК"
                onClicked: stack.pop()
            }
        }
    }
}
