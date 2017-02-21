/*
 *
 * onDragChanged  to do
 * ok~

*/

import QtQuick 2.7
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtMultimedia 5.4

import File 1.0

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    color: systemPalette.window
    SystemPalette{id: systemPalette}
    FontLoader{id: uiFont; source: "qrc:/fonts/PingFangM.ttf"}
    menuBar:MenuBar{
        Menu{
            title: "显示"
            MenuItem{text: "语料库"; onTriggered: {viewer.showData()}}
            MenuItem{text: "计划书"; onTriggered: {viewer.showSchedule()}}
        }
        Menu{
            title: "函数"
            MenuItem{text: "条件概率函数"; onTriggered: {funcer.showCondFunc()}}
            MenuItem{text: "频率统计函数"; onTriggered: {funcer.showHZ()}}
        }
        Menu{
            title: "输入"
            MenuItem{text: "输入正确分析"; onTriggered: {inputer.judge()}}
        }
    }

    Item{
        id: btns
        anchors.fill: parent
        visible: false
        Button{
            id: dataBtn
            x: 100; y: 100
            text: "单词库"
            onClicked: viewer.showData()
        }
        Button{
            id: scheduleBtn
            x: 100; y: 200
            text: "计划书"
            onClicked: viewer.showSchedule()
        }
        Button{
            id: articleBtn
            x: 100; y: 300
            text: "文本库"
            onClicked: viewer.showArticle()
        }

        Button{
            id: pBtn
            x: 250; y: 100
            text: "条件概率函数"
            onClicked: {}
        }
        Button{
            id: hzBtn
            x: 250; y: 200
            text: "频率统计函数"
            onClicked: {}
        }
        Button{
            id: analyCorrect
            x: 400; y: 100
            text: "正确输入分析"
            onClicked: inputer.judge()
        }

    }

    property string dataString
    property var dataObj
    property string schedule
    property string article

    View{
        id: viewer
    }

    Func{
        id: funcer
    }

    Input{
        id: inputer
    }

    Component.onCompleted: inputDataAndSchedule()
    function inputDataAndSchedule(){
        // data
        if(File.exist(":/data.json")) console.log("Data input successfully~")
        else console.log("Data input error!")
        var d = File.read(":/data.json")
        if(!d) console.log("***data read Error.")
        var j = JSON.parse(d)
        dataString = d
        dataObj = j
        console.log(dataObj.wo[1])

        // schedule
        if(File.exist(":/schedule.txt")) console.log("Schedule input successfully~")
        else console.log("Schedule input error!")
        schedule = File.read(":/schedule.txt")
        if(!schedule) console.log("***Schedule read error!")

        // article
        if(File.exist(":/article.txt")) console.log("Article input successfully~")
        else console.log("Article input error!")
        article = File.read(":/article.txt")
        if(!article) console.log("***Article read error!")
        btns.visible = true
    }


}
