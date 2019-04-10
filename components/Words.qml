import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3

Item {
    property int selected_word: 0
    property string vocub_title
    ColumnLayout {
        anchors.fill: parent
        ListView {
            id: wordsList
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: wordsModel
            delegate: Component {
                Rectangle {
                    width: parent.width
                    height: fraction * 2
                    RowLayout {
                        width: parent.width
                        height: parent.height
                        Rectangle {
                            Layout.fillWidth: true
                            height: parent.height
                            Text {
                                anchors.centerIn: parent
                                text: native_word+" - "+foreign_word
                                font.pixelSize: fraction
                            }
                        }
                        Image {
                            source: "qrc:///svg/edit.svg"
                            sourceSize.width: fraction
                            sourceSize.height: fraction
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
                            sourceSize.width: fraction
                            sourceSize.height: fraction
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    dialogAndroid.open()
                                }
                            }
                        }
                    }
                }
            }
        }
        Button {
            text: "Добавить слово"
            font.pixelSize: fraction
            implicitWidth: parent.width
            onClicked: {
                selected_word = -1
                stack.push(wordSaveCancelContainer)
            }
        }
    }
    MessageDialog {
        id: dialogAndroid
        text: "Удалить?"
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            controller.removeWord(vocub_title, wordsModel.get(selected_word).foreign_word)
            dialogAndroid.close()
        }
        onNo: dialogAndroid.close()
    }
    Component {
        id: wordSaveCancelContainer
        SaveCancelContainer {
            content: Word {
                vocabulary_title: title
                native_word: {
                    if (selected_word > -1)
                        wordsModel.get(selected_word).native_word
                    else
                        ""
                }
                foreign_word: {
                    if (selected_word > -1)
                        wordsModel.get(selected_word).foreign_word
                    else
                        ""
                }
            }
        }
    }
}
