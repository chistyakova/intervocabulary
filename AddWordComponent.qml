import QtQuick 2.0
import QtQuick.Controls 2.0

Component {
    Rectangle {
        color: "#00ffff"
        Button {
            anchors.top: parent.top
            anchors.left: parent.left
            text: "< НАЗАД"
            onClicked: stack.pop()
        }
        Column {
            spacing: 5
            anchors.centerIn: parent
            width: parent.width
            TextField  {
                id: newWordNative
                placeholderText: qsTr("Слово")
            }
            TextField  {
                id: newWordTranslation
                placeholderText: qsTr("Перевод")
            }
            Button {
                width: parent.width
                text: "ОК"
                onClicked: controller.addNewWord(newWordNative.text, newWordTranslation.text)
            }
        }
    }
}
