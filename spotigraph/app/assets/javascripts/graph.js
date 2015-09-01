function show_graph(graph_nodes, graph_edges){
    /** give nodes/edges global scope for testing later (makes it easier to
      * ensure we handed off the correct information to vis.js. Also makes it
      * easier to ensure that we have the correct relationships between artists.
      */
    nodes = new vis.DataSet(graph_nodes);
    edges = new vis.DataSet(graph_edges);
    var container = document.getElementById('mynetwork');
    var data = { nodes: nodes, edges: edges};
    var options = {
        physics:{
            enabled: true,
            maxVelocity: 25,
        }
    };
    var network = new vis.Network(container, data, options);
}