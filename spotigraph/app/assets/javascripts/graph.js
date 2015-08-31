function show_graph(graph_nodes, graph_edges){
    var nodes = new vis.DataSet(graph_nodes);
    var edges = new vis.DataSet(graph_edges);
    var container = document.getElementById('mynetwork');
    var data = { nodes: nodes, edges: edges};
    var options = {
        physics:{
            enabled: true,
            maxVelocity: 25,
        }
    };
    var network = new vis.Network(container, data, options);
    return { nodes: nodes, edges: edges }
}