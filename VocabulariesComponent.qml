import QtQuick 2.0
import QtQuick.Controls 2.0

Component {
    Rectangle {
        anchors.fill: parent
        color: "#ff00ff"
        Button {
            anchors.top: parent.top
            anchors.left: parent.left
            text: "< НАЗАД"
            onClicked: stack.pop()
        }
        Text {
            anchors.centerIn: parent //не знаю как выровнять сверху по центру
            text: "MОИ СЛОВАРИ"
        }
        Button {
            anchors.centerIn: parent
            width: parent.width
            text: "Добавить язык"
            onClicked: stack.push(addLanguageComponent)
        }
    }
}
