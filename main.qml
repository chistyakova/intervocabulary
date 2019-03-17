import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import "."

Rectangle {
    id: mainRectangle

    // Для Desktop:
    width: Screen.desktopAvailableWidth / 4
    height: Screen.desktopAvailableHeight / 2

    StackView {
        id: stack
        initialItem: mainComponent
        anchors.fill: parent
    }
    Component {
        id: mainComponent
        Rectangle {
            color: "#00ffff"
            Column {
                anchors.centerIn: parent
                width: parent.width
                Button {
                    width: parent.width
                    text: "ТРЕНИРОВКА"
                    onClicked: stack.push(trainingComponent)
                }
                Button {
                    width: parent.width
                    text: "МОИ СЛОВАРИ"
                    onClicked: stack.push(vocabulariesComponent)
                }
                Button {
                    width: parent.width
                    text: "О ПРОГРАММЕ"
                    onClicked: stack.push(aboutComponent)
                }
            }
        }
    }


    TrainingComponent {
        id: trainingComponent
    }

    VocabulariesComponent {
        id: vocabulariesComponent
    }

    AboutComponent {
        id: aboutComponent
    }

}

