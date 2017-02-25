import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2

Item {
    property var word: []
    property var words: []
    ApplicationWindow{
        id: inputShow
        width: 300; height: 450
        color: systemPalette.window
        TextField{
            id: input
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.family: uiFont.name
            text: "text input"
        }
        Button{
            anchors.top: input.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: input.horizontalCenter
            text: "sure"
            onClicked: {
                output.text = ""
                inputShow.showJudge()
            }
        }
        TextArea{
            id: output
            anchors.top: input.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: input.horizontalCenter
            font.family: uiFont.name
            text: ""
        }
        TextArea{
            id: output2
            anchors.top: output.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: input.horizontalCenter
            height: 40
            font.family: uiFont.name
            text: ""
        }
        Button{
            id: showFreq
            anchors.top: output2.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: input.horizontalCenter
            text: "ShowFreq"
            onClicked: {
                var freq = []
                freq = funcer.getAllWordFreq(inputer.word, mainWindow.article)
                console.log(freq)

                for(var i = 0; i < word.length; ++i){
                    for(var j = 0; j < word[i].length; ++j){
                        output2.text = output2.text + word[i][j] + " " + freq[i][j] + "   "
                    }
                    output2.text = output2.text + "\n"
                }
            }
        }
        TextArea{
            id: output3
            anchors.top: showFreq.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: input.horizontalCenter
            height: 40
            font.family: uiFont.name
            text: ""
        }
        Button{
            id: showFreq2
            anchors.top: output3.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: input.horizontalCenter
            text: "ShowBitFreq"
            onClicked: {
                var bitWords = [], freq = []
                bitWords = funcer.getBitGramWords(inputer.word)
                freq = funcer.getAllWordFreq(bitWords)

                for(var i = 0; i < bitWords.length; ++i){
                    for(var j = 0; j < bitWords[i].length; ++j){
                        output3.text = output3.text + bitWords[i][j] + " " + freq[i][j] + "   "
                    }
                    output3.text = output3.text + "\n"
                }
            }
        }


        function judge(){
            var pinyinArray = [], allPinyinArray = [], ans = []
            var pinyinLength = []
            var min = 100, max = 0
            for(var key in mainWindow.dataObj){
                var s = key + ""
                if(s.length < min) min = s.length
                if(s.length > max) max = s.length
                pinyinArray.push(s)
                pinyinLength.push(s.length)
            }

            var inputLength = input.length
            var maxNum = Math.ceil(inputLength/min), minNum = Math.ceil(inputLength/max)
            console.log(minNum, maxNum, pinyinLength, inputLength)
            allPinyinArray = getAllpinyinArray(minNum, maxNum, pinyinLength, inputLength)
            console.log(allPinyinArray)
            var ss = ""
            for(var i in allPinyinArray){
                for(var j in allPinyinArray[i]){
                    ss = ss + pinyinArray[allPinyinArray[i][j]]
                }
                //console.log("Debug: ", ss)
                if(ss === input.text){
                    word = []; var l = allPinyinArray[i].length
                    for(var k in allPinyinArray[i]){
                        var word1 = []
                        for(var chinese in dataObj[pinyinArray[allPinyinArray[i][k]]])
                            word1.push(dataObj[pinyinArray[allPinyinArray[i][k]]][chinese])

                        word.push(word1)
                        word1 = []
                    }

                    if(l === 1){
                        for(var i1 in word[0])
                            words.push(word[0][i1])
                    }else if(l === 2){
                        for(var i2 in word[0])
                            for(var j2 in word[1])
                                words.push(word[0][i2] + word[1][j2])
                    }else if(l === 3){
                        for(var i3 in word[0])
                            for(var j3 in word[1])
                                for(var k3 in word[2])
                                    words.push(word[0][i3] + word[1][j3] + word[2][k3])
                    }else if(l === 4){
                        for(var i4 in word[0])
                            for(var j4 in word[1])
                                for(var k4 in word[2])
                                    for(var l4 in word[3])
                                        words.push(word[0][i4] + word[1][j4] + word[2][k4] + word[3][l4])
                    }else if(l === 5){
                        for(var i5 in word[0])
                            for(var j5 in word[1])
                                for(var k5 in word[2])
                                    for(var l5 in word[3])
                                        for(var m5 in word[4])
                                            words.push(word[0][i5] + word[1][j5] + word[2][k5] + word[3][l5] + word[4][m5])
                    }else if(l === 6){
                        for(var i6 in word[0])
                            for(var j6 in word[1])
                                for(var k6 in word[2])
                                    for(var l6 in word[3])
                                        for(var m6 in word[4])
                                            for(var n6 in word[6])
                                                words.push(word[0][i6] + word[1][j6] + word[2][k6] + word[3][l6] + word[4][m6] + word[5][n6])
                    }
                    console.log("Finally: ", words)
                    console.log("Word: ", word)
                    output.text = ""

                    var wordsP = []
                    wordsP = funcer.getWordsP(words)
                    for(var eachWord in words){
                        output.text = output.text + "[" + words[eachWord] + " " + wordsP[eachWord] + "] "
                    }

                    return true
                }
                ss = ""
            }

            return false

//            for(var i = minNum; i <= maxNum; ++i){
//                var word = ""
//                for(var j = 0; j < i; j++){
//                    for(var each in pinyinArray){
//                        word = word + pinyinArray[each]
//                    }
//                }
//                console.log("Debug: ", word)
//                if(word.length === inputLength){
//                    allPinyinArray.push(word)
//                }
//            }
//            console.log(allPinyinArray, min, max)

        }
        function showJudge(){
            if(judge()) input.textColor = "green"
            else input.textColor = "red"
        }

        // too many repeat
        function getAllpinyinArray(minNum, maxNum, pinyinLength, inputLength){
            var list = [], ans = []
            if(minNum === 1 && maxNum === 1){
                for(var i11 in pinyinLength){
                    if(pinyinLength[i11] === inputLength){
                        list.push(i11)
                        ans.push(list)
                    }
                    list = []
                }
            }else if(minNum === 1 && maxNum === 2){
                for(var i12 in pinyinLength){
                    if(pinyinLength[i12] === inputLength){
                        list.push(i12)
                        ans.push(list)
                    }
                    list = []
                }
                for(var ii12 in pinyinLength){
                    for(var jj12 in pinyinLength){
                        if(pinyinLength[ii12] + pinyinLength[jj12] === inputLength){
                            list.push(ii12); list.push(jj12)
                            ans.push(list)
                        }
                        list = []
                    }
                }
            }else if(minNum === 1 && maxNum === 3){
                for(var i13 in pinyinLength){
                    if(pinyinLength[i13] === inputLength){
                        list.push(i13)
                        ans.push(list)
                    }
                    list = []
                }
                for(var ii13 in pinyinLength){
                    for(var jj13 in pinyinLength){
                        if(pinyinLength[ii13] + pinyinLength[jj13] === inputLength){
                            list.push(ii13); list.push(jj13)
                            ans.push(list)
                        }
                        list = []
                    }
                }
                for(var iii13 in pinyinLength){
                    for(var jjj13 in pinyinLength){
                        for(var kkk13 in pinyinLength){
                            if(pinyinLength[iii13] + pinyinLength[jjj13] + pinyinLength[kkk13] === inputLength){
                                list.push(iii13); list.push(jjj13); list.push(kkk13)
                                ans.push(list)
                            }
                            list = []
                        }

                    }
                }
            }else if(minNum === 1 && maxNum === 4){
                for(var i14 in pinyinLength){
                    if(pinyinLength[i14] === inputLength){
                        list.push(i14)
                        ans.push(list)
                    }
                    list = []
                }
                for(var ii14 in pinyinLength){
                    for(var jj14 in pinyinLength){
                        if(pinyinLength[ii14] + pinyinLength[jj14] === inputLength){
                            list.push(ii14); list.push(jj14)
                            ans.push(list)
                        }
                        list = []
                    }
                }
                for(var iii14 in pinyinLength){
                    for(var jjj14 in pinyinLength){
                        for(var kkk14 in pinyinLength){
                            if(pinyinLength[iii14] + pinyinLength[jjj14] + pinyinLength[kkk14] === inputLength){
                                list.push(iii14); list.push(jjj14); list.push(kkk14)
                                ans.push(list)
                            }
                            list = []
                        }

                    }
                }
                for(var iiii14 in pinyinLength){
                    for(var jjjj14 in pinyinLength){
                        for(var kkkk14 in pinyinLength){
                            for(var wwww14 in pinyinLength){
                                if(pinyinLength[iiii14] + pinyinLength[jjjj14] + pinyinLength[kkkk14] + pinyinLength[wwww14] === inputLength){
                                    list.push(iiii14); list.push(jjjj14); list.push(kkkk14); list.push(wwww14)
                                    ans.push(list)
                                }
                                list = []
                            }
                        }
                    }
                }
            }else if(minNum === 1 && maxNum === 5){
                for(var i15 in pinyinLength){
                    if(pinyinLength[i15] === inputLength){
                        list.push(i15)
                        ans.push(list)
                    }
                    list = []
                }
                for(var ii15 in pinyinLength){
                    for(var jj15 in pinyinLength){
                        if(pinyinLength[ii15] + pinyinLength[jj15] === inputLength){
                            list.push(ii15); list.push(jj15)
                            ans.push(list)
                        }
                        list = []
                    }
                }
                for(var iii15 in pinyinLength){
                    for(var jjj15 in pinyinLength){
                        for(var kkk15 in pinyinLength){
                            if(pinyinLength[iii15] + pinyinLength[jjj15] + pinyinLength[kkk15] === inputLength){
                                list.push(iii15); list.push(jjj15); list.push(kkk15)
                                ans.push(list)
                            }
                            list = []
                        }

                    }
                }
                for(var iiii15 in pinyinLength){
                    for(var jjjj15 in pinyinLength){
                        for(var kkkk15 in pinyinLength){
                            for(var wwww15 in pinyinLength){
                                if(pinyinLength[iiii15] + pinyinLength[jjjj15] + pinyinLength[kkkk15] + pinyinLength[wwww15] === inputLength){
                                    list.push(iiii15); list.push(jjjj15); list.push(kkkk15); list.push(wwww15)
                                    ans.push(list)
                                }
                                list = []
                            }
                        }
                    }
                }
                for(var iiiii15 in pinyinLength)
                    for(var jjjjj15 in pinyinLength)
                        for(var kkkkk15 in pinyinLength)
                            for(var wwwww15 in pinyinLength)
                                for(var lllll15 in pinyinLength){
                                    if(pinyinLength[iiiii15] + pinyinLength[jjjjj15] + pinyinLength[kkkkk15] + pinyinLength[wwwww15] + pinyinLength[lllll15] === inputLength){
                                        list.push(iiiii15); list.push(jjjjj15); list.push(kkkkk15); list.push(lllll15)
                                        ans.push(list)
                                    }
                                    list = []
                                }
            }else if(minNum === 1 && maxNum === 6){
                for(var i16 in pinyinLength){
                    if(pinyinLength[i16] === inputLength){
                        list.push(i16)
                        ans.push(list)
                    }
                    list = []
                }
                for(var ii16 in pinyinLength){
                    for(var jj16 in pinyinLength){
                        if(pinyinLength[ii16] + pinyinLength[jj16] === inputLength){
                            list.push(ii16); list.push(jj16)
                            ans.push(list)
                        }
                        list = []
                    }
                }
                for(var iii16 in pinyinLength){
                    for(var jjj16 in pinyinLength){
                        for(var kkk16 in pinyinLength){
                            if(pinyinLength[iii16] + pinyinLength[jjj16] + pinyinLength[kkk16] === inputLength){
                                list.push(iii16); list.push(jjj16); list.push(kkk16)
                                ans.push(list)
                            }
                            list = []
                        }

                    }
                }
                for(var iiii16 in pinyinLength){
                    for(var jjjj16 in pinyinLength){
                        for(var kkkk16 in pinyinLength){
                            for(var wwww16 in pinyinLength){
                                if(pinyinLength[iiii16] + pinyinLength[jjjj16] + pinyinLength[kkkk16] + pinyinLength[wwww16] === inputLength){
                                    list.push(iiii16); list.push(jjjj16); list.push(kkkk16); list.push(wwww16)
                                    ans.push(list)
                                }
                                list = []
                            }
                        }
                    }
                }
                for(var iiiii16 in pinyinLength)
                    for(var jjjjj16 in pinyinLength)
                        for(var kkkkk16 in pinyinLength)
                            for(var wwwww16 in pinyinLength)
                                for(var lllll16 in pinyinLength){
                                    if(pinyinLength[iiiii16] + pinyinLength[jjjjj16] + pinyinLength[kkkkk16] + pinyinLength[wwwww16] + pinyinLength[lllll16] === inputLength){
                                        list.push(iiiii16); list.push(jjjjj16); list.push(kkkkk16); list.push(lllll16)
                                        ans.push(list)
                                    }
                                    list = []
                                }
                for(var iiiiii16 in pinyinLength)
                    for(var jjjjjj16 in pinyinLength)
                        for(var kkkkkk16 in pinyinLength)
                            for(var wwwwww16 in pinyinLength)
                                for(var llllll16 in pinyinLength)
                                    for(var mmmmmm16 in pinyinLength){
                                        if(pinyinLength[iiiiii16] + pinyinLength[jjjjjj16] + pinyinLength[kkkkkk16] + pinyinLength[wwwwww16] + pinyinLength[llllll16] + pinyinLength[mmmmmm16] === inputLength){
                                            list.push(iiiiii16); list.push(jjjjjj16); list.push(kkkkkk16); list.push(llllll16); list.push(mmmmmm16)
                                            ans.push(list)
                                        }
                                        list = []
                                    }
            }else if(minNum === 1 && maxNum === 7){
                for(var i17 in pinyinLength){
                    if(pinyinLength[i17] === inputLength){
                        list.push(i17)
                        ans.push(list)
                    }
                    list = []
                }
                for(var ii17 in pinyinLength){
                    for(var jj17 in pinyinLength){
                        if(pinyinLength[ii17] + pinyinLength[jj17] === inputLength){
                            list.push(ii17); list.push(jj17)
                            ans.push(list)
                        }
                        list = []
                    }
                }
                for(var iii17 in pinyinLength){
                    for(var jjj17 in pinyinLength){
                        for(var kkk17 in pinyinLength){
                            if(pinyinLength[iii17] + pinyinLength[jjj17] + pinyinLength[kkk17] === inputLength){
                                list.push(iii17); list.push(jjj17); list.push(kkk17)
                                ans.push(list)
                            }
                            list = []
                        }
                    }
                }
                for(var iiii17 in pinyinLength){
                    for(var jjjj17 in pinyinLength){
                        for(var kkkk17 in pinyinLength){
                            for(var wwww17 in pinyinLength){
                                if(pinyinLength[iiii17] + pinyinLength[jjjj17] + pinyinLength[kkkk17] + pinyinLength[wwww17] === inputLength){
                                    list.push(iiii17); list.push(jjjj17); list.push(kkkk17); list.push(wwww17)
                                    ans.push(list)
                                }
                                list = []
                            }
                        }
                    }
                }
                for(var iiiii17 in pinyinLength)
                    for(var jjjjj17 in pinyinLength)
                        for(var kkkkk17 in pinyinLength)
                            for(var wwwww17 in pinyinLength)
                                for(var lllll17 in pinyinLength){
                                    if(pinyinLength[iiiii17] + pinyinLength[jjjjj17] + pinyinLength[kkkkk17] + pinyinLength[wwwww17] + pinyinLength[lllll17] === inputLength){
                                        list.push(iiiii17); list.push(jjjjj17); list.push(kkkkk17); list.push(lllll17)
                                        ans.push(list)
                                    }
                                    list = []
                                }
                for(var iiiiii17 in pinyinLength)
                    for(var jjjjjj17 in pinyinLength)
                        for(var kkkkkk17 in pinyinLength)
                            for(var wwwwww17 in pinyinLength)
                                for(var llllll17 in pinyinLength)
                                    for(var mmmmmm17 in pinyinLength){
                                        if(pinyinLength[iiiiii17] + pinyinLength[jjjjjj17] + pinyinLength[kkkkkk17] + pinyinLength[wwwwww17] + pinyinLength[llllll17] + pinyinLength[mmmmmm17] === inputLength){
                                            list.push(iiiiii17); list.push(jjjjjj17); list.push(kkkkkk17); list.push(llllll17); list.push(mmmmmm17)
                                            ans.push(list)
                                        }
                                        list = []
                                    }
            }else if(minNum === 2 && maxNum === 2){
                for(var ii22 in pinyinLength){
                    for(var jj22 in pinyinLength){
                        if(pinyinLength[ii22] + pinyinLength[jj22] === inputLength){
                            list.push(ii22); list.push(jj22)
                            ans.push(list)
                        }
                        list = []
                    }
                }
            }else if(minNum === 2 && maxNum === 3){
                for(var ii23 in pinyinLength){
                    for(var jj23 in pinyinLength){
                        if(pinyinLength[ii23] + pinyinLength[jj23] === inputLength){
                            list.push(ii23); list.push(jj23)
                            ans.push(list)
                        }
                        list = []
                    }
                }
                for(var iii23 in pinyinLength){
                    for(var jjj23 in pinyinLength){
                        for(var kkk23 in pinyinLength){
                            if(pinyinLength[iii23] + pinyinLength[jjj23] + pinyinLength[kkk23] === inputLength){
                                list.push(iii23); list.push(jjj23); list.push(kkk23)
                                ans.push(list)
                            }
                            list = []
                        }

                    }
                }
            }else if(minNum === 2 && maxNum === 4){
                for(var ii24 in pinyinLength){
                    for(var jj24 in pinyinLength){
                        if(pinyinLength[ii24] + pinyinLength[jj24] === inputLength){
                            list.push(ii24); list.push(jj24)
                            ans.push(list)
                        }
                        list = []
                    }
                }
                for(var iii24 in pinyinLength){
                    for(var jjj24 in pinyinLength){
                        for(var kkk24 in pinyinLength){
                            if(pinyinLength[iii24] + pinyinLength[jjj24] + pinyinLength[kkk24] === inputLength){
                                list.push(iii24); list.push(jjj24); list.push(kkk24)
                                ans.push(list)
                            }
                            list = []
                        }

                    }
                }
                for(var iiii24 in pinyinLength){
                    for(var jjjj24 in pinyinLength){
                        for(var kkkk24 in pinyinLength){
                            for(var wwww24 in pinyinLength){
                                if(pinyinLength[iiii24] + pinyinLength[jjjj24] + pinyinLength[kkkk24] + pinyinLength[wwww24] === inputLength){
                                    list.push(iiii24); list.push(jjjj24); list.push(kkkk24); list.push(wwww24)
                                    ans.push(list)
                                }
                                list = []
                            }
                        }
                    }
                }
            }else if(minNum === 3 && maxNum === 3){
                for(var iii33 in pinyinLength){
                    for(var jjj33 in pinyinLength){
                        for(var kkk33 in pinyinLength){
                            if(pinyinLength[iii33] + pinyinLength[jjj33] + pinyinLength[kkk33] === inputLength){
                                list.push(iii33); list.push(jjj33); list.push(kkk33)
                                ans.push(list)
                            }
                            list = []
                        }
                    }
                }
            }else if(minNum === 3 && maxNum === 4){
                for(var iii34 in pinyinLength){
                    for(var jjj34 in pinyinLength){
                        for(var kkk34 in pinyinLength){
                            if(pinyinLength[iii34] + pinyinLength[jjj34] + pinyinLength[kkk34] === inputLength){
                                list.push(iii34); list.push(jjj34); list.push(kkk34)
                                ans.push(list)
                            }
                            list = []
                        }
                    }
                }
                for(var iiii34 in pinyinLength){
                    for(var jjjj34 in pinyinLength){
                        for(var kkkk34 in pinyinLength){
                            for(var wwww34 in pinyinLength){
                                if(pinyinLength[iiii34] + pinyinLength[jjjj34] + pinyinLength[kkkk34] + pinyinLength[wwww34] === inputLength){
                                    list.push(iiii34); list.push(jjjj34); list.push(kkkk34); list.push(wwww34)
                                    ans.push(list)
                                }
                                list = []
                            }
                        }
                    }
                }
            }else if(minNum === 4 && maxNum === 4){
                for(var iiii44 in pinyinLength){
                    for(var jjjj44 in pinyinLength){
                        for(var kkkk44 in pinyinLength){
                            for(var wwww44 in pinyinLength){
                                if(pinyinLength[iiii44] + pinyinLength[jjjj44] + pinyinLength[kkkk44] + pinyinLength[wwww44] === inputLength){
                                    list.push(iiii44); list.push(jjjj44); list.push(kkkk44); list.push(wwww44)
                                    ans.push(list)
                                }
                                list = []
                            }
                        }
                    }
                }
            }
            return ans
        }


    }
    function judge(){
        inputShow.show()
    }
}
