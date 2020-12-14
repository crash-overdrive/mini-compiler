

// read in from file, check the lines at the end, look for th lines, print

#include <vector> 
#include <iostream>
#include <fstream> 
#include <sstream>
#include <stack> 

using namespace std;

int main() {
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
   int n; 
   cin >> n;
   for(int i = 0; i < n; i++) {
    cin >> now;
   }
   cin >> n;
   for(int i = 0; i < n; i++) {
    cin >> now;
   }
    cin >> now;
   cin >> n;
   getline(cin, now);
   for(int i = 0; i <= n; i++) {
    getline(cin, now);
    istringstream iss{now};
    string sss ;
    while(iss >> sss) {
    vec.push_back(sss);
    }
   rules.push_back(vec);
   vec.clear();
   } 
   cin >> n;
   getline(cin, now);
   for(int i = 1; i <= n; i++) {
    getline(cin, now);
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
 while(cin >> now) {
        tmp.push(now);
    }
    int ts = tmp.size();
    for(int i = 0; i < ts; i++) {
        input.push(tmp.top());
        tmp.pop();
    }
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
            if(l == state.top() &&
               v[i][1] == symbol.top()) {
                if(v[i][2] == "reduce") {
                    istringstream iss{v[i][v[i].size()-1]};
                    int k;
                    iss >> k;
                    //make rule a vector of vectors
                    int len = rules[k].size() -1;
                    input.push(symbol.top());
                    symbol.pop();
                    for(int i = len; i > 0; i--) {
                        if(rules[k][i] == symbol.top()) {
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
     for(int i = 0; i < print.size(); i++) {
        for(int j  = 0; j < print[i].size(); j++) {
            cout << print[i][j] << " ";
        }
        cout << endl;
    }
    for(int i = 0; i < rules[0].size(); i++) {
     cout << rules[0][i] << " ";
    }
     cout << endl;
    } catch(int &msg) {
      cerr << "ERROR at " << msg << endl;

    }
}
