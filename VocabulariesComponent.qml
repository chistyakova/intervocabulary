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
            id: header
            anchors.top: parent.top //не знаю как выровнять сверху по центру
            anchors.horizontalCenter: parent.horizontalCenter
            text: "MОИ СЛОВАРИ"
        }
        ListView {
            anchors.centerIn: parent
            height: 90
            width: 300
            model: ListModel {
                ListElement {
                    language: "Korean"
                    title: "ККЦ 1 курс"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 2 курс"
                }
                ListElement {
                    language: "English"
                    title: "Слова из сериала Офис"
                }
            }
            Component {
                    id: dictionaryDelegate
                    Button {
                        width: 300
                        height: 30
                        text: language + ": " + title
                        onClicked: stack.push(wordListComponent)

                    }
                }

            delegate: dictionaryDelegate
        }
        Button {
            anchors.bottom: parent.bottom
            width: parent.width
            text: "Добавить язык"
            onClicked: stack.push(addLanguageComponent)
        }
    }
}
