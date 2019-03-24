import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import "components"

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
            Column {
                anchors.centerIn: parent
                width: parent.width
                spacing: 5
                padding : 5
                Button {
                    width: parent.width
                    text: "ТРЕНИРОВКА"
                    onClicked: stack.push(training001CloseContainer)
                }
                Button {
                    width: parent.width
                    text: "МОИ СЛОВАРИ"
                    onClicked: stack.push(vocabulariesTitleContainer)
                }
                Button {
                    width: parent.width
                    text: "О ПРОГРАММЕ"
                    onClicked: stack.push(aboutTitleContainer)
                }
            }
        }
    }

    Component {
        id: trainingPoppable
        TitleContainer {
            title: ""
            content: Rectangle {
                color: "red"
                Text {
                    text: "dynamic comonent"
                }
            }
        }
    }

    Component {
        id: vocabulariesTitleContainer
        TitleContainer {
            title: "МОИ СЛОВАРИ"
            content: Vocabularies {}
        }
    }

    Component {
        id: aboutTitleContainer
        TitleContainer {
            title: "О ПРОГРАММЕ"
            content: About {}
        }
    }

    Component {
        id: training001CloseContainer
        CloseContainer {
            content: Training001 {}
        }
    }
}

