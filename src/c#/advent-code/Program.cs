using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace advent_code
{
    public class Node
    {
        public List<string> Children { get; set; } = new List<string>();
        public string Name { get; set; }
        public int Weight { get; set; }
    }

    public class NodeTuple
    {
        public Node NodeRef { get; set; } = null;
        public int Count { get; set; } = 0;
    }

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            var nodes = ReadFileInput.GetValues(@"../../input/day7.txt");
            Node baseNode = GetTreeBase(nodes);

            var sums = new List<int>();

            foreach (var nodeName in baseNode.Children)
            {
                Console.WriteLine($"nodename: {nodeName}");
                Node childNode = nodes.FirstOrDefault(n => n.NodeRef.Name == nodeName).NodeRef;
                int sum = 0;
                GetSumOfBranch(nodes, childNode, ref sum);
                sums.Add(sum);
            }

            foreach (var sum in sums)
            {
                Console.WriteLine($"sum: {sum}");
            }

            Console.WriteLine($"Base node is {baseNode.Name} Bye World!");
        }

        private static void GetSumOfBranch(List<NodeTuple> nodes, Node childNode, ref int sum)
        {
            sum += childNode.Weight;
            foreach (var childName in childNode.Children)
            {
                Node grandChildNode = nodes.FirstOrDefault(n => n.NodeRef.Name == childName).NodeRef;
                GetSumOfBranch(nodes, grandChildNode, ref sum);
            }
            
        }

        private static Node GetTreeBase(List<NodeTuple> nodes)
        {
            int maxCount = -1;
            Node baseNode = null;
            
            List<NodeTuple> parentNodes = nodes.Select(n =>
            {
                if (n?.NodeRef?.Children?.Count > 0)
                {
                    n.Count++;
                }
                return n;
            }).ToList();

            
            foreach (var nodeTuple in parentNodes)
            {
                int count = 1;
                ExploreNode(nodes, nodeTuple.NodeRef, ref count);

                maxCount = Math.Max(maxCount, count);

                if(count >= maxCount)
                {
                    baseNode = nodeTuple.NodeRef;
                }
            }
            

            return baseNode;
        }

        private static void ExploreNode(List<NodeTuple> nodes, Node node, ref int count)
        {
            if(node.Children.Count <= 0)
            {
                return;
            }

            count++;

            foreach (var child in node.Children)
            {
                count++;
                var childNode = nodes.FirstOrDefault(n => n.NodeRef.Name == child)?.NodeRef;
                ExploreNode(nodes, childNode, ref count);   
            }
        }
    }

    public class ReadFileInput
    {
        public static List<NodeTuple> GetValues(string fileName)
        {
            var nodes = new List<NodeTuple>();
            var lines = File.ReadAllLines(fileName);
            foreach (var line in lines)
            {
                var words = line.Split(' ');
                var weightStr = words[1];
                weightStr = weightStr.Remove(weightStr.IndexOf(")"), 1);
                weightStr = weightStr.Remove(weightStr.IndexOf("("), 1);
                int.TryParse(weightStr, out int weight);

                var children = new List<string>();
                for (int i = 3; i < words.Length; i++)
                {
                    var child = words[i];
                    if (child.Contains(","))
                    {
                        child = child.Remove(child.IndexOf(','));
                    }
                    children.Add(child);
                }

                nodes.Add(new NodeTuple
                {
                    NodeRef = new Node
                    {
                        Name = words[0],
                        Weight = weight,
                        Children = children
                    }
                });
            }
            return nodes;
        }
    }
}
