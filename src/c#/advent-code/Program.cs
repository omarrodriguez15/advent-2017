using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace advent_code
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            Day7();
        }

        static void Day7()
        {
            NodeStuff ns = new NodeStuff();
            var nodes = ReadFileInput.GetValues(@"../../input/day7.txt");
            Node baseNode = ns.GetTreeBase(nodes);
            Node node = ns.GetUnbalancedNode(nodes, baseNode);
            // var unbalancedChild = baseNode.Children[2];
            // Node unbalancedNode = nodes.FirstOrDefault(n => n.NodeRef.Name == unbalancedChild).NodeRef;
            Console.WriteLine($"Base node is {baseNode.Name} Bye World!");
        }
    }
}
