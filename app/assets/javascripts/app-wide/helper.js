function stringToNode(node_string) {
    var temp_node = document.createElement("div");
    temp_node.innerHTML = node_string;
    return temp_node.firstChild;
}
