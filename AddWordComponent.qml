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
            Text {
                text: qsTr("Слово")
            }
            TextField  {
                id: newWordNative
            }
            Text {
                text: qsTr("Перевод")
            }
            TextField  {
                id: newWordTranslation
            }
            anchors.centerIn: parent
            width: parent.width
            Button {
                width: parent.width
                text: "ОК"
                onClicked: controller.addNewWord(newWordNative.text, newWordTranslation.text)
            }
        }
    }
}
