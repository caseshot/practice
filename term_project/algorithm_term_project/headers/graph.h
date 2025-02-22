#ifndef _GRAPH_H_
#define _GRAPH_H_

#include "my_vector.h"

class Graph {
    using pii = std::pair<int, int>;
    using pid = std::pair<int, double>;
    using pdi = std::pair<double, int>;
    static const int MAX_POINT_NUM = 100 * 3;
    static const int INF = 0x3f3f3f3f;

    struct Edge {
        Edge() = default;
        Edge(int u, int v, int w);
        int u, v, w;
        bool operator>= (const Edge& rhs) const;
        bool operator<= (const Edge& rhs) const;
    };

    void PrintPoint(int pos) const;

private:
    my::vector<pii> _points;
    my::vector<my::vector<pid>> _edges;
    my::vector<int> _borderPoint;
    my::vector<pdi> _pointDist;
    my::vector<Edge> _unionEdges;

    bool _vis[MAX_POINT_NUM];
    double _dist[MAX_POINT_NUM];
    int _path[MAX_POINT_NUM];

public:
    Graph();
    void CreateGraph();
    size_t ShortestPath();
    void ShowPath(int pos) const;
    void MinJumpNum() const;
    void MinimumSpanningTree();
};

#endif
