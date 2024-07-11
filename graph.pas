program DijkstraAlgorithm;

uses
  SysUtils, Math;

const
  MaxInt = 32767;
  MaxNodes = 100;

type
  TGraph = array[1..MaxNodes, 1..MaxNodes] of Integer;
  TDist = array[1..MaxNodes] of Integer;
  TVisited = array[1..MaxNodes] of Boolean;

var
  Graph: TGraph;
  Distance: TDist;
  Visited: TVisited;
  NodeCount: Integer;

procedure InitializeGraph(var G: TGraph; NodeCount: Integer);
var
  i, j: Integer;
begin
  for i := 1 to NodeCount do
    for j := 1 to NodeCount do
      G[i, j] := MaxInt;
end;

procedure AddEdge(var G: TGraph; u, v, weight: Integer);
begin
  G[u, v] := weight;
  G[v, u] := weight;
end;

procedure Dijkstra(G: TGraph; Source, NodeCount: Integer; var Dist: TDist);
var
  i, j, MinDist, NextNode: Integer;
begin
  for i := 1 to NodeCount do
  begin
    Dist[i] := MaxInt;
    Visited[i] := False;
  end;

  Dist[Source] := 0;

  for i := 1 to NodeCount - 1 do
  begin
    MinDist := MaxInt;

    for j := 1 to NodeCount do
      if (not Visited[j]) and (Dist[j] < MinDist) then
      begin
        MinDist := Dist[j];
        NextNode := j;
      end;

    Visited[NextNode] := True;

    for j := 1 to NodeCount do
      if (not Visited[j]) and (G[NextNode, j] <> MaxInt) and
         (Dist[NextNode] + G[NextNode, j] < Dist[j]) then
      begin
        Dist[j] := Dist[NextNode] + G[NextNode, j];
      end;
  end;
end;

procedure PrintDistances(Dist: TDist; NodeCount: Integer);
var
  i: Integer;
begin
  WriteLn('Node    Distance from Source');
  for i := 1 to NodeCount do
    WriteLn(i:5, Dist[i]:18);
end;

begin
  Write('Enter the number of nodes: ');
  ReadLn(NodeCount);

  InitializeGraph(Graph, NodeCount);

  AddEdge(Graph, 1, 2, 10);
  AddEdge(Graph, 1, 3, 5);
  AddEdge(Graph, 2, 3, 2);
  AddEdge(Graph, 2, 4, 1);
  AddEdge(Graph, 3, 2, 3);
  AddEdge(Graph, 3, 4, 9);
  AddEdge(Graph, 3, 5, 2);
  AddEdge(Graph, 4, 5, 4);
  AddEdge(Graph, 5, 4, 6);
  AddEdge(Graph, 5, 1, 7);

  Dijkstra(Graph, 1, NodeCount, Distance);

  PrintDistances(Distance, NodeCount);
end.

