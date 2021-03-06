﻿using System;
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
            //advent_code.d112.DayEleven.DoWork();
        }

        static void Day7()
        {
            NodeStuff ns = new NodeStuff();
            var nodes = ReadFileInput.GetValues(@"../../input/day7.txt");
            Node baseNode = ns.GetTreeBase(nodes);
            Node node = ns.GetUnbalancedNode(nodes, baseNode);
            
            Console.WriteLine($"UnBalanced node is {node.Name}!");
            Console.WriteLine($"Base node is {baseNode.Name} !");
        }
    }
}
