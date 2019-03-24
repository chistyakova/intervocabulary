import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Item {
    property int selected_word: 0
    ColumnLayout {
        anchors.fill: parent
        ListView {
            id: wordsList
            Layout.fillHeight: true
            Layout.fillWidth: true
            // model: dictionariesModel
            model: ListModel {
                id: wordsModel
                ListElement {
                    own: "кошка"
                    foreign: "cat"
                }
                ListElement {
                    own: "собака"
                    foreign: "dog"
                }
                ListElement {
                    own: "дом"
                    foreign: "home"
                }
                ListElement {
                    own: "штаны"
                    foreign: "pants"
                }
            }
            delegate: Component {
                Rectangle {
                    width: parent.width
                    height: 24
                    RowLayout {
                        width: parent.width
                        height: 24
                        Rectangle {
                            Layout.fillWidth: true
                            height: 24
                            Text {
                                anchors.centerIn: parent
                                text: own+" - "+foreign
                            }
                        }
                        Image {
                            source: "qrc:///svg/edit.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selected_word = index
                                    stack.push(wordSaveCancelContainer)
                                }
                            }
                        }
                        Image {
                            source: "qrc:///svg/delete.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
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
            text: "Добавить слово"
            onClicked: {
                selected_word = -1
                stack.push(wordSaveCancelContainer)
            }
        }
    }
    Component {
        id: wordSaveCancelContainer
        SaveCancelContainer {
            content: Word {
                vocabulary_title: title
                native_word: {
                    if (selected_word > -1)
                        wordsModel.get(selected_word).own
                    else
                        ""
                }
                foreign_word: {
                    if (selected_word > -1)
                        wordsModel.get(selected_word).foreign
                    else
                        ""
                }
            }
        }
    }
}
