#include <string>
#include <vector>
#include <iostream>
#include <stdlib.h>

struct Node {
    int num; // -1 if node is array
    std::vector<Node> arr;
};

Node parse(const char*& str) 
{
    Node n {-1};
    while(*str) {
        if(*str=='[') n.arr.push_back(parse(++str)); // subarr
        else if(*str==']') { ++str; return n; } // end of current array
        else if(*str==',') { ++str; } // next element
        else n.arr.push_back({(int)strtol(str, (char**)&str, 10), {}}); //number
    }
    return n;
}

// wrap numbernode in one-elem array
Node wrap_numnode(Node n)
{
    return { -1, {{n.num}} };
}

// return 1 if left is lesser
// return 0 if nodes are equal
// return -1 if left is greater
int cmp(const Node& left, const Node& right)
{
    if(left.num != -1 && right.num != -1){ // both are numbers
        if(left.num < right.num) return 1;
        if(left.num == right.num) return 0;
        if(left.num > right.num) return -1;
    }
    else if(left.num == -1 && right.num == -1) { // both are arrays
        for(int i = 0; i<right.arr.size() && i<left.arr.size(); ++i) {
            if(cmp(left.arr[i], right.arr[i])) return cmp(left.arr[i], right.arr[i]);
        }
        // when all elems are equal, the sizes decide
        if(left.arr.size() < right.arr.size()) return 1;
        if(left.arr.size() == right.arr.size()) return 0;
        if(left.arr.size() > right.arr.size()) return -1;
    }
    else { // one is array
        if(left.num != -1) return cmp(wrap_numnode(left), right);
        if(right.num != -1) return cmp(left, wrap_numnode(right));
    }
}

int main()
{
    std::string left, right;
    int sum = 0;
    for(int i = 1; std::cin>>left>>right; ++i) {
        const char* l_ptr = left.c_str();
        const char* r_ptr = right.c_str();
        if(cmp(parse(l_ptr), parse(r_ptr)) >= 0) sum += i;
    }
    std::cout<<sum<<"\n";
}
