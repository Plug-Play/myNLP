import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2

Item {
    ApplicationWindow{
        id: dataShow
        width: 300; height: 350
        color: systemPalette.window
        TextArea{
            anchors.fill: parent
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.family: uiFont.name
            text: dataString
        }
    }
    function showData(){
        dataShow.show()
    }
    ApplicationWindow{
        id: scheduleShow
        width: 300; height: 350
        color: systemPalette.window
        TextArea{
            anchors.fill: parent
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.family: uiFont.name
            text: schedule
        }
    }
    function showSchedule(){
        scheduleShow.show()
    }
    ApplicationWindow{
        id: articleShow
        width: 300; height: 350
        color: systemPalette.window
        TextArea{
            anchors.fill: parent
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.family: uiFont.name
            text: article
        }
    }
    function showArticle(){
        articleShow.show()
    }

}
