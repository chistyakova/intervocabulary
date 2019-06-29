import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Page {
    property int selected_vocabulary: 0
//    property Item header: Component {
//        Rectangle {
//            anchors.fill: parent
//            Text {
//                anchors.centerIn: parent
//                text: "Словари"
//            }
//        }
//    }
    property Item body: Component {
        ColumnLayout {
            anchors.fill: parent
            ListView {
                id: vocabulariesList
                Layout.fillHeight: true
                Layout.fillWidth: true
                model: vocubsModel
                delegate: Component {
                    Rectangle {
                        width: vocabulariesList.width
                        height: fraction * 2
                        color: index % 2 == 0 ? "#efefef" : "#f8f8f8" // чередуем цвет полосок в ListView
                        RowLayout {
                            anchors.fill: parent
                            Image {
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
                            Rectangle {
                                Layout.fillWidth: true
                                height: fraction
                                color: "transparent"
                                Text {
                                    anchors.left: parent.left
                                    text: title
                                    font.pixelSize: fraction
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        selected_vocabulary = index
                                        controller.getWords(
                                                    vocubsModel.get(selected_vocabulary).title)
                                        stack.push(wordsTitleContainer)
                                    }
                                }
                            }
                            Image {
                                source: "qrc:///svg/edit.svg"
                                sourceSize.width: fraction
                                sourceSize.height: fraction
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        selected_vocabulary = index
                                        editVocub.open()
                                    }
                                }
                            }
                            Image {
                                source: "qrc:///svg/delete.svg"
                                sourceSize.width: fraction
                                sourceSize.height: fraction
                                MouseArea {
                                    anchors.fill: parent
                                    onPressAndHold: {
                                        console.log("delete "+index)
                                    }
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
