import QtQuick 2.0

// article, inputer.words[i]， inputer.word[i][j]
Item {
    function getAllWordFreq(word){
        var i = 0, j = 0
        var partAns = [], ans = []
        for(i = 0; i < word.length; ++i){
            for(j = 0; j < word[i].length; ++j){
                partAns.push(getEachWordFreq(word[i][j]))
            }
            ans.push(partAns)
        }
        return ans
    }

    function getEachWordFreq(eachWord){
        var wordLen = eachWord.length
        var ans = 0
        var i = 0, j = 0
        for(i = 0; i < article.length - wordLen + 1; ++i)
            for(j = 0; j < wordLen; ++j)
                if(article[i + j] === eachWord[j])
                    ans ++
        return ans
    }

    function getBitGramWords(words){
        var ans = [], partAns = []
        var eachLineLength = []
        for(var lineLength in words)
            eachLineLength.push(words[lineLength].length)
        for(var i in words){
            for(var j in words[i]){
                partAns = []
                for(var ii in words){
                    if(ii === i) continue
                    for(var jj in words[ii]){
                        var eachAns = ""
                        eachAns = eachAns + words[i][j] + words[ii][jj]
                        partAns.push(eachAns)
                    }
                }
                ans.push(partAns)
            }
        }
        console.log(ans)
        return ans
    }

    function getWordsP(words){
        var ans = []
        for(var eachWord in words){
            var eachWordLen = words[eachWord].length
            var partAns = getEachWordFreq(words[eachWord][0]) / article.length
            for(var i = 0; i < eachWordLen - 1; ++i){
                var fenzi = getEachWordFreq(words[eachWord][i] + words[eachWord][i + 1])
                var fenmu = getEachWordFreq(words[eachWord][i])
                partAns = partAns * fenzi / fenmu
            }
            ans.push(partAns)
        }
        return ans
    }
}
