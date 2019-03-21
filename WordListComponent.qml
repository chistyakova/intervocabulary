import QtQuick 2.0
import QtQuick.Controls 2.0

Component {
    id: wordListComponent
    Rectangle {
        color: "#00ffff"
        Button {
            anchors.top: parent.top
            anchors.left: parent.left
            text: "< НАЗАД"
            onClicked: stack.pop()
        }
        ListView {
            width: 300; height: 300
            anchors.centerIn: parent

            contentWidth: 320
            flickableDirection: Flickable.AutoFlickDirection

            model: dictionaryModel
            delegate: Text {text: model.native+" - "+model.translation}

        }
        Button {
            width: parent.width
            anchors.bottom: parent.bottom
            text: "Добавить слово"
            onClicked: stack.push(addWordComponent)
        }
    }
}
