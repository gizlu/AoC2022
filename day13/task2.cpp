#include <string>
#include <vector>
#include <iostream>
#include <stdlib.h>
#include <algorithm>

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

// wrap cmp into callback for std::sort
int sort_cmp(const Node& l, const Node& r)
{
    if(cmp(l,r) == -1) return 0;
    else return 1;
}


Node parse_packet_str(std::string s) {
    const char* ptr = s.c_str();
    return parse(ptr);
}

void print_tree(Node& tree)
{
    std::cout<<"[";
    for(int i = 0; i<tree.arr.size(); ++i) {
        if(i!=0) std::cout<<",";
        if(tree.arr[i].num != -1) std::cout<<tree.arr[i].num;
        else print_tree(tree.arr[i]);
    }
    std::cout<<"]";
}

int main()
{
    std::string s;
    std::vector<Node> packets;
    for(int i = 1; std::cin>>s; ++i) {
        packets.push_back(parse_packet_str(s));
    }
    packets.push_back(parse_packet_str("[[2]]"));
    packets.push_back(parse_packet_str("[[6]]"));
    std::sort(packets.begin(), packets.end(), sort_cmp);
    for(auto p : packets) {
        print_tree(p); std::cout<<"\n";
    }
}
