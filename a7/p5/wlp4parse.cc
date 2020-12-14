

// read in from file, check the lines at the end, look for th lines, print

#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <stack>

using namespace std;

struct Node{
    vector<string>str;
    vector <Node *>children;
    int nonterminals;
    ~Node() {
        for(int i = 0; i < children.size(); i++) {
            delete children[i];
        }
    }
};



bool checkval(string s) {
    if(s == "dcl" || s == "dcls" || s == "expr"|| s == "factor" ||
       s == "lvalue" || s == "procedure" || s == "procedures" || s == "main"
       || s == "params" || s == "paramlist" || s == "statement" || s == "statements"
       || s == "term" || s == "test" || s == "type" || s == "arglist" || s == "start") {
        return true;
    }
    return false;
}


Node* buildNode(vector< vector<string>>&print, int &k) {
    Node *curr = NULL;
    if(k < 0) return curr;
    vector<Node *>v;
    int orig = k;
    k = k - 1;
    int number = 0;
    int nnumber = 0;
    for(int j = 1; j < print[orig].size(); j++) {
        if(checkval(print[orig][j])) {
            number = number  + 1;
        } else {
            nnumber = nnumber + 1;
        }
    }
    int kk = k;
    for(int j = 0; j < number; j++) {
        Node *n = buildNode(print, kk);
        v.push_back(n);
    }
    curr = new Node{print[orig], v, nnumber};
    k = kk;
    return curr;
}

void TraverseTree(Node *currr, stack<string> &next) {
    vector <string> example;
    for(int i = 0; i < currr->str.size(); i++) {
        cout << currr->str[i] << " ";
    }
    cout << endl;
    
    
    int count = 0;
    int q = (currr->children).size() - 1;
    for(int i = 1; i < currr->str.size(); i++) {
        if(checkval(currr->str[i])) {
          TraverseTree(currr->children[q], next);
            q--;
        } else {
            cout << next.top() << endl;
            next.pop();
            count++;
        }
    }
}



int main(int argc, const char * argv[]) {
    string s;
    string sss;
    string now;
    vector <vector<string>>rules;
    vector <vector<string>>v;
    stack <string> symbol;
    stack <int> state;
    stack <string>tmp;
    stack <string>input;
    vector<vector<string>>print;
    vector<string>vec;
    stack <string>next;
    int n;
    ifstream inFile{"input"};
    inFile >> n;
    for(int i = 0; i < n; i++) {
        inFile >> now;
    }
    inFile >> n;
    for(int i = 0; i < n; i++) {
        inFile >> now;
    }
    inFile >> now;
    inFile >> n;
    getline(inFile, now);
    for(int i = 0; i <= n; i++) {
        getline(inFile, now);
        istringstream iss{now};
        string sss ;
        while(iss >> sss) {
            vec.push_back(sss);
        }
        rules.push_back(vec);
        vec.clear();
    }
    inFile >> n;
    getline(inFile, now);
    for(int i = 1; i <= n; i++) {
        getline(inFile, now);
        istringstream iss{now};
        string sss ;
        while(iss >> sss) {
            vec.push_back(sss);
        }
        v.push_back(vec);
        vec.clear();
    }
    //start at state 0, check input and check for rule. If
    //read input into a stack
    // cout << v << endl;
    while(getline(cin, now)) {
        tmp.push(now); // it reads the entire line in
    }
    int ts = tmp.size();
    input.push("EOF");
    next.push("EOF EOF");
    for(int i = 0; i < ts; i++) {
        input.push(tmp.top());
        next.push(tmp.top());
        tmp.pop();
    }
    input.push("BOF");
    next.push("BOF BOF");
    
    int e = input.size();
    state.push(0);
    symbol.push(input.top());
    input.pop();
    bool a = true;
    try {
        while(a) {
            for(int i = 0; i < v.size(); i++) {
                istringstream ssi{v[i][0]};
                int l;
                ssi >> l;
                istringstream si{symbol.top()};
                string q;
                si >> q;
                if(l == state.top() &&
                   v[i][1] ==q) {
                    if(v[i][2] == "reduce") {
                        istringstream iss{v[i][v[i].size()-1]};
                        int k;
                        iss >> k;
                        //make rule a vector of vectors
                        int len = rules[k].size() -1;
                        input.push(symbol.top());
                        symbol.pop();
                        for(int i = len; i > 0; i--) {
                            string str;
                            istringstream iii{symbol.top()};
                            iii >> str;
                            if(rules[k][i] == str) {
                                symbol.pop();
                                state.pop();
                            }
                        }
                        print.push_back(rules[k]);
                        symbol.push(rules[k][0]);
                    } else {
                        istringstream iss{v[i][v[i].size() -1]};
                        int l;
                        iss >> l;
                        state.push(l);
                        if(input.size() == 0) {
                            a = false;
                            break;
                        } else {
                            symbol.push(input.top());
                            input.pop();
                        }
                    }
                    
                    break;
                }
                if(i == (v.size() -1)) {
                    e = e - input.size();
                    throw e;
                }
            }
        }
        
        print.push_back(rules[0]);

        int i = print.size() -1;
        Node *n = buildNode(print, i);
        TraverseTree(n, next);
        delete n;
        
    } catch(int &msg) {
        cerr << "ERROR at " << (msg - 1) << endl;
        
    }
}
