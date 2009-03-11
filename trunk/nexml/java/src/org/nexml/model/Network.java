package org.nexml.model;

import java.util.Set;

public interface Network<E extends Edge> extends NexmlWritable {
	E createEdge();

	void removeEdge(E edge);
	
	Set<E> getEdges();

	Node createNode();

	void removeNode(Node node);

	Set<Node> getNodes();
}
