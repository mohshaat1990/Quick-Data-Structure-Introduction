//
//  Graph.swift
//  
//
//  Created by Mohamed Shaat on 8/17/19.
//

import Foundation



class Vertex<Element: Equatable> {
    var value: Element
    private(set) var adjacentEdges:[DirectedEdge<Element>] = []
    init(_ value: Element) {
        self.value = value
    }
    
    func addEdge(_ edge: DirectedEdge<Element>) {
        self.adjacentEdges.append(edge)
    }
    
    func edgeForDestination(_ destination: Vertex<Element>) -> DirectedEdge<Element>? {
        return adjacentEdges.filter { $0.destination == destination }.first
    }
}
extension Vertex: Equatable {
    static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.value == rhs.value && lhs.adjacentEdges == rhs.adjacentEdges
    }
}

class DirectedEdge<Element: Equatable> {
    var source: Vertex<Element>
    var destination: Vertex<Element>
    var weight: Double
    
    init(source: Vertex<Element>, destination: Vertex<Element>, weight: Double) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
    
}
extension DirectedEdge: Equatable {
    static func ==(lhs: DirectedEdge, rhs: DirectedEdge) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight
    }
}

class EdgeWeightedDigraph<Element: Equatable> {
    private(set) var vertices: [Vertex<Element>] = []
    
    func addVertex(_ vertex: Vertex<Element>) {
        vertices.append(vertex)
    }
    func addEdge(source: Vertex<Element>, destination: Vertex<Element>, weight: Double) {
        
        // If we find an existing edge, just update the weight.
        if let existingEdge = source.edgeForDestination(destination) {
            existingEdge.weight = weight
        } else {
            let newEdge = DirectedEdge<Element>(source: source, destination: destination, weight: weight)
            source.addEdge(newEdge)
        }
    }
}

let dublin = Vertex<String>("Dublin")
let london = Vertex<String>("London")
let paris = Vertex<String>("Paris")
let amsterdam = Vertex<String>("Amsterdam")
let montreal = Vertex<String>("Montreal")
let sanFrancisco = Vertex<String>("San Francisco")
let graph = EdgeWeightedDigraph<String>()
graph.addVertex(dublin)
graph.addVertex(london)
graph.addVertex(paris)
graph.addVertex(amsterdam)
graph.addVertex(montreal)
graph.addVertex(sanFrancisco)
graph.addEdge(source: dublin, destination: london, weight: 20)
graph.addEdge(source: dublin, destination: amsterdam, weight: 25)
graph.addEdge(source: dublin, destination: paris, weight: 35)
graph.addEdge(source: london, destination: paris, weight: 10)
graph.addEdge(source: london, destination: montreal, weight: 200)
graph.addEdge(source: london, destination: sanFrancisco, weight: 500)
graph.addEdge(source: paris, destination: amsterdam, weight: 10)
graph.addEdge(source: paris, destination: sanFrancisco, weight: 400)
graph.addEdge(source: amsterdam, destination: montreal, weight: 300)
graph.addEdge(source: amsterdam, destination: sanFrancisco, weight: 450)
graph.addEdge(source: montreal, destination: sanFrancisco, weight: 200)
graph.addEdge(source: sanFrancisco, destination: dublin, weight: 700)
