import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
    property int selected_vocabulary: 0
    property Component header: Component {
        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Словари"
                font.pixelSize: fraction
                Layout.alignment: Qt.AlignCenter // заголовок посередине первой ячейки
            }
            Image {
                Layout.alignment: Qt.AlignRight // иконка редактирования с самого правого второй края ячейки
                source: "qrc:///svg/edit.svg"
                sourceSize.width: fraction
                sourceSize.height: fraction
                MouseArea {
                    anchors.fill: parent
                    onClicked: {}
                }
            }
        }
    }
    property Component body: Component {
        ColumnLayout {
            anchors.fill: parent
            ListView {
                Layout.fillHeight: true
                Layout.fillWidth: true
                model: vocubsModel
                delegate: Component {
                    Rectangle {
                        width: parent.width
                        height: fraction * 2
                        color: index % 2 == 0 ? "#efefef" : "#f8f8f8" // чередуем цвет полосок в ListView
                        RowLayout {
                            anchors.fill: parent
                            Image { // первая ячейка - инидкация выбранности/невыбранности словаря
                                source: flag ? "qrc:/svg/checked.svg" : "qrc:/svg/unchecked.svg"
                                sourceSize.width: fraction
                                sourceSize.height: fraction
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        console.log(flag)
                                        selected_vocabulary = index
                                        controller.toggleVocubFlag(
                                                    vocubsModel.get(selected_vocabulary).title)
                                    }
                                }
                            }
                            MouseArea { // вторая ячейка кликабельна и содержит текст название словаря
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                onClicked: {
                                    selected_vocabulary = index
                                    controller.getWords(
                                                vocubsModel.get(selected_vocabulary).title)
                                    stack.push(wordsTitleContainer)
                                }
                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: title
                                    font.pixelSize: fraction
                                }
                            }
                        }
                    }
                }
            }
            Button {
                text: "Добавить словарь"
                font.pixelSize: fraction
                implicitWidth: parent.width // Button не имеет поля width, вместо него это!
                onClicked: {
                    selected_vocabulary = -1
                    editVocub.open()
                }
            }
            Dialog {
                id: editVocub
                modal: true
                focus: true
                title: "Добавить словарь"
                standardButtons: Dialog.Ok | Dialog.Cancel
                parent: Overlay.overlay
                width: parent.width
                ColumnLayout {
                    spacing: 20
                    anchors.fill: parent
                    TextField {
                        id: flagField
                        placeholderText: "Язык"
                        Layout.fillWidth: true
                        text: selected_vocabulary<0?"":vocubsModel.get(selected_vocabulary).flag
                    }
                    TextField {
                        id: titleField
                        focus: true
                        placeholderText: "Название словаря"
                        Layout.fillWidth: true
                        text: selected_vocabulary<0?"":vocubsModel.get(selected_vocabulary).title
                    }
                    TextField {
                        id: descriptionFiled
                        placeholderText: "Описание словаря"
                        Layout.fillWidth: true
                        text: selected_vocabulary<0?"":vocubsModel.get(selected_vocabulary).description
                    }
                }
                onAccepted: controller.saveVocab(
                                flagField.text,
                                titleField.text,
                                descriptionFiled.text)
            }
        }
    }
    Component {
        id: wordsTitleContainer
        SlideContainer {
            content: Words {
                vocub_title: vocubsModel.get(selected_vocabulary).title
            }
        }
    }
}
