using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace advent_code
{
   //749
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

   public class NodeStuff
   {
      public Node GetUnbalancedNode(List<NodeTuple> nodes, Node baseNode)
      {
         var sumMap = new List<Tuple<int, string>>();

         foreach (var nodeName in baseNode.Children)
         {
            //Console.WriteLine($"nodename: {nodeName}");
            Node childNode = nodes.FirstOrDefault(n => n.NodeRef.Name == nodeName).NodeRef;
            int sum = 0;
            GetSumOfBranch(nodes, childNode, ref sum);
            sumMap.Add(new Tuple<int, string>(sum, nodeName));
         }

         var hashTable = new Dictionary<int, Tuple<int, string>>();
         var commonWeight = int.MinValue;
         Console.WriteLine($"\r\nBase Name: {baseNode.Name} Weight: {baseNode.Weight}");
         foreach (var sum in sumMap)
         {
            Console.WriteLine($"Name: {sum.Item2} Weight: {sum.Item1}");
            if(hashTable.ContainsKey(sum.Item1))
            {
               commonWeight = sum.Item1;
            }
            else
            {
               hashTable.Add(sum.Item1, sum);
            }
         }

         Node unbalancedNode = null;
         foreach (var sum in sumMap)
         {
            if(sum.Item1 != commonWeight)
            {
               unbalancedNode = nodes.FirstOrDefault(n => n.NodeRef.Name == sum.Item2).NodeRef;
               unbalancedNode = GetUnbalancedNode(nodes, unbalancedNode);
            }
         }
         
         return unbalancedNode ?? baseNode;
      }

      private void GetSumOfBranch(List<NodeTuple> nodes, Node childNode, ref int sum)
      {
         sum += childNode.Weight;
         foreach (var childName in childNode.Children)
         {
            Node grandChildNode = nodes.FirstOrDefault(n => n.NodeRef.Name == childName).NodeRef;
            GetSumOfBranch(nodes, grandChildNode, ref sum);
         }
      }

      public Node GetTreeBase(List<NodeTuple> nodes)
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

      private void ExploreNode(List<NodeTuple> nodes, Node node, ref int count)
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