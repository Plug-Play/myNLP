#include <iostream>
#include <string>
#define len 6
using namespace std;

string s("<s> I am Sam </s> <s> Sam I am </s> <s> I do not like green eggs and ham </s>");
string words[len] = {"I", "<s>", "Sam", "am", "</s>", "do"};
int freq[len] = {0, 0, 0, 0, 0, 0};
int bitFreq[len][len] = {
    {0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0},
};


void calFreq(string ori, string *word, int *f){
    for(int i = 0; i < len; ++i){
        int wordLen = word[i].length();
        // cout<< wordLen<<endl;
        for(int j = 0; j < ori.length() - wordLen + 1; ++j){
            string partOri = s.substr(j, wordLen);
            //cout<< partOri<<endl;
            if(partOri == word[i])
                f[i]++;
        }
        cout<<word[i]<<": "<< f[i]<<endl;
    }
}

void calBitFreq(string ori, string *word, int f[len][len]){
    for(int i = 0; i < len; ++i){
        for(int ii = 0; ii < len; ++ii){
            string realWord = word[i] + " " + word[ii];
            int wordLen = realWord.length();
            // cout<< wordLen<<endl;
            for(int j = 0; j < ori.length() - wordLen + 1; ++j){
                string partOri = s.substr(j, wordLen);
                //cout<< partOri<<endl;
                if(partOri == realWord)
                    f[i][ii]++;
            }
            cout<< realWord<<": "<< f[i][ii] <<endl;
        }
    }
}

// {"I", "<s>", "Sam", "am", "</s>", "do"};
double ans[len] = {0, 0, 0, 0, 0, 0};
void calP(){
    // P(I|<s>)
    ans[0] = bitFreq[1][0] * 1.0 / freq[1];
    // P(Sam|<s>)
    ans[1] = bitFreq[1][2] * 1.0 / freq[1];
    // P(am|I)
    ans[2] = bitFreq[0][3] * 1.0 / freq[0];
    // P(</s>|Sam)
    ans[3] = bitFreq[2][4] * 1.0 / freq[2];
    // P(Sam|am)
    ans[4] = bitFreq[3][2] * 1.0 / freq[3];
    // P(do|I)
    ans[5] = bitFreq[0][5] * 1.0 / freq[0];

    // output
    for(int i = 0; i < len; ++i)
        cout<< "answer: "<< ans[i] <<endl;
}

int main()
{
    calFreq(s, words, freq);
    calBitFreq(s, words, bitFreq);
    calP();
    return 0;
}
